import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/estudante.controller.dart';
import 'package:sme_app_aluno/controllers/background_fetch/background_fetch.controller.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/screens/dashboard/dashboard.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/ui/views/login.view.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class EstudanteListaView extends StatefulWidget {
  EstudanteListaView();

  @override
  _EstudanteListaViewState createState() => _EstudanteListaViewState();
}

class _EstudanteListaViewState extends State<EstudanteListaView> {
  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();

  BackgroundFetchController _backgroundFetchController;

  @override
  void initState() {
    super.initState();
    _backgroundFetchController = BackgroundFetchController();
    _loadingAllStudents();
    _backgroundFetchController.initPlatformState(
      _onBackgroundFetch,
      "${AppConfigReader.getBundleIdentifier()}.verificaSeUsuarioTemAlunoVinculado",
      10000,
    );
  }

  void _onBackgroundFetch(String taskId) async {
    bool responsibleHasStudent = await _backgroundFetchController
        .checkIfResponsibleHasStudent(_usuarioStore.id);
    print(
        '[BackgroundFetch] - INIT -> ${AppConfigReader.getBundleIdentifier()}.verificaSeUsuarioTemAlunoVinculado');
    if (responsibleHasStudent == false) {
      Auth.logout(context, _usuarioStore.id, true);
    }

    BackgroundFetch.finish(taskId);
  }

  _logoutUser() async {
    await Auth.logout(context, _usuarioStore.usuario.id, true);
  }

  Widget _itemCardStudent(BuildContext context, EstudanteModel model,
      String groupSchool, int codigoGrupo, int userId) {
    return EAEstudanteCard(
      name: model.nomeSocial != null && model.nomeSocial.isNotEmpty
          ? model.nomeSocial
          : model.nome,
      schoolName: model.escola,
      studentGrade: model.turma,
      codigoEOL: model.codigoEol,
      schooType: model.descricaoTipoEscola,
      dreName: model.siglaDre,
      onPress: () {
        Nav.push(
            context,
            Dashboard(
                userId: _usuarioStore.id,
                estudante: model,
                groupSchool: groupSchool,
                codigoGrupo: codigoGrupo));
      },
    );
  }

  Widget _listStudents(List<EstudanteModel> students, BuildContext context,
      String groupSchool, int codigoGrupo, int userId) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < students.length; i++) {
      list.add(_itemCardStudent(
          context, students[i], groupSchool, codigoGrupo, userId));
    }
    return new Column(children: list);
  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text("Deseja sair do aplicativo?"),
            actions: <Widget>[
              FlatButton(
                child: Text("SIM"),
                onPressed: () {
                  Auth.logout(context, _usuarioStore.id, false);
                  Nav.pushReplacement(context, LoginView());
                },
              ),
              FlatButton(
                child: Text("NÃO"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

  _loadingAllStudents() async {
    await _estudanteController.obterEstudantes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Estudantes"),
        backgroundColor: Color(0xffEEC25E),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Auth.logout(context, _usuarioStore.id, false);
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
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
                AutoSizeText(
                  "ALUNOS CADASTRADOS PARA O RESPONSÁVEL",
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(
                      color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenHeight * 3.5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: screenHeight * 74,
                    child: Observer(builder: (context) {
                      if (_estudanteStore.carregando) {
                        return GFLoader(
                          type: GFLoaderType.square,
                          loaderColorOne: Color(0xffDE9524),
                          loaderColorTwo: Color(0xffC65D00),
                          loaderColorThree: Color(0xffC65D00),
                          size: GFSize.LARGE,
                        );
                      } else {
                        if (_estudanteStore.gruposEstudantes == null &&
                            _usuarioStore.id != null) {
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
                                    text: "${dados[index].grupo}",
                                    color: Color(0xffC65D00),
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
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
