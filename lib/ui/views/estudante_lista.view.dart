import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/background_fetch/background_fetch.controller.dart';
import '../../controllers/estudante.controller.dart';
import '../../models/estudante.model.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/widgets/tag/tag_custom.dart';
import '../../stores/index.dart';
import '../../utils/app_config_reader.dart';
import '../../utils/auth.dart';
import '../../utils/navigator.dart';
import '../index.dart';

class EstudanteListaView extends StatefulWidget {
  const EstudanteListaView({super.key});

  @override
  EstudanteListaViewState createState() => EstudanteListaViewState();
}

class EstudanteListaViewState extends State<EstudanteListaView> {
  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();

  final BackgroundFetchController _backgroundFetchController = BackgroundFetchController();

  @override
  void initState() {
    super.initState();
    _loadingAllStudents();
    _backgroundFetchController.initPlatformState(
      _onBackgroundFetch,
      '${AppConfigReader.getBundleIdentifier()}.verificaSeUsuarioTemAlunoVinculado',
      10000,
    );
  }

  void _onBackgroundFetch(String taskId) async {
    final bool responsibleHasStudent = await _backgroundFetchController.checkIfResponsibleHasStudent(_usuarioStore.id);
    log('[BackgroundFetch] - INIT -> ${AppConfigReader.getBundleIdentifier()}.verificaSeUsuarioTemAlunoVinculado');
    if (responsibleHasStudent == false) {
      authLogout();
    }

    BackgroundFetch.finish(taskId);
  }

  void authLogout() {
    Auth.logout(context, _usuarioStore.id, true);
  }

  void _logoutUser() async {
    await Auth.logout(context, _usuarioStore.usuario.id, true);
  }

  Widget _itemCardStudent(BuildContext context, EstudanteModel model, String groupSchool, int codigoGrupo, int userId) {
    return EAEstudanteCard(
      name: model.nomeSocial.isNotEmpty ? model.nomeSocial : model.nome,
      schoolName: model.escola,
      studentGrade: model.turma,
      codigoEOL: model.codigoEol,
      schooType: model.descricaoTipoEscola,
      dreName: model.siglaDre,
      onPress: () {
        Nav.push(
          context,
          Dashboard(userId: _usuarioStore.id, estudante: model, groupSchool: groupSchool, codigoGrupo: codigoGrupo),
        );
      },
    );
  }

  Widget _listStudents(
    List<EstudanteModel> students,
    BuildContext context,
    String groupSchool,
    int codigoGrupo,
    int userId,
  ) {
    final List<Widget> list = [];
    for (var i = 0; i < students.length; i++) {
      list.add(_itemCardStudent(context, students[i], groupSchool, codigoGrupo, userId));
    }
    return Column(children: list);
  }

  Future<bool> _onBackPress() async {
    bool retorno = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Deseja sair do aplicativo?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                Auth.logout(context, _usuarioStore.id, false);
                retorno = true;
                Nav.pushReplacement(context, const LoginView(notice: ''));
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                retorno = false;
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
    return retorno;
  }

  void _loadingAllStudents() async {
    await _estudanteController.obterEstudantes();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        title: const Text('Estudantes'),
        backgroundColor: const Color(0xffEEC25E),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Auth.logout(context, _usuarioStore.id, false);
            },
            icon: Icon(
              FontAwesomeIcons.rightFromBracket,
              size: screenHeight * 2,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackPress,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 2.5,
                ),
                const AutoSizeText(
                  'ALUNOS CADASTRADOS PARA O RESPONSÁVEL',
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenHeight * 3.5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight * 74,
                  child: Observer(
                    builder: (context) {
                      if (_estudanteStore.carregando && !_estudanteStore.erroCarregar) {
                        return const GFLoader(
                          type: GFLoaderType.square,
                          loaderColorOne: Color(0xffDE9524),
                          loaderColorTwo: Color(0xffC65D00),
                          loaderColorThree: Color(0xffC65D00),
                          size: GFSize.LARGE,
                        );
                      } else {
                        if (_estudanteStore.erroCarregar) {
                          return const Center(
                            child: AutoSizeText(
                              'Erro ao carregar lista de Estudantes',
                              maxFontSize: 18,
                              minFontSize: 14,
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                            ),
                          );
                        }
                        if (_estudanteStore.gruposEstudantes.isEmpty) {
                          _logoutUser();
                          return Container();
                        } else {
                          return ListView.builder(
                            itemCount: _estudanteStore.gruposEstudantes.length,
                            itemBuilder: (context, index) {
                              final dados = _estudanteStore.gruposEstudantes;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TagCustom(
                                    text: dados[index].grupo,
                                    color: const Color(0xffC65D00),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 2,
                                  ),
                                  _listStudents(
                                    dados[index].estudantes,
                                    context,
                                    dados[index].grupo,
                                    dados[index].codigoGrupo,
                                    _usuarioStore.id,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
