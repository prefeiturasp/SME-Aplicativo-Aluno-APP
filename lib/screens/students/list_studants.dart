import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/controllers/students.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/dashboard/dashboard.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/students/widgets/cards/card_students.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';
import 'package:sme_app_aluno/utils/auth.dart';

class ListStudants extends StatefulWidget {
  final String cpf;
  final String token;
  final String password;

  ListStudants(
      {@required this.cpf, @required this.token, @required this.password});

  @override
  _ListStudantsState createState() => _ListStudantsState();
}

class _ListStudantsState extends State<ListStudants> {
  AuthenticateController _authenticateController;
  StudentsController _studentsController;

  @override
  void initState() {
    super.initState();
    _authenticateController = AuthenticateController();
    _studentsController = StudentsController();
    _loadingAllStudents();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    BackgroundFetch.configure(
            BackgroundFetchConfig(
              minimumFetchInterval: 2,
              forceAlarmManager: false,
              stopOnTerminate: false,
              startOnBoot: true,
              enableHeadless: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false,
              requiredNetworkType: NetworkType.NONE,
            ),
            _onBackgroundFetch)
        .then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 10000,
        periodic: true,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true));
  }

  void _onBackgroundFetch(String taskId) async {
    await _authenticateController.authenticateUser(widget.cpf, widget.password);

    print(
        "[ DEBUG ] ListStudants._onBackgroundFetch: CurrentUser: ${jsonEncode(_authenticateController.currentUser)}");

    if (_authenticateController.currentUser.erros != null &&
        _authenticateController.currentUser.erros.isNotEmpty &&
        _authenticateController.currentUser.erros.length > 0 &&
        _authenticateController.currentUser.erros[0] != null) {
      Auth.logout(context);
    }

    BackgroundFetch.finish(taskId);
  }

  Widget _itemCardStudent(BuildContext context, Student model, String token,
      String groupSchool, int codigoGrupo) {
    return CardStudent(
      name: model.nomeSocial != null ? model.nomeSocial : model.nome,
      schoolName: model.escola,
      studentGrade: model.turma,
      schooType: model.descricaoTipoEscola,
      onPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                    student: model,
                    groupSchool: groupSchool,
                    token: token,
                    codigoGrupo: codigoGrupo)));
      },
    );
  }

  Widget _listStudents(List<Student> students, BuildContext context,
      String groupSchool, String token, int codigoGrupo) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < students.length; i++) {
      list.add(_itemCardStudent(
          context, students[i], token, groupSchool, codigoGrupo));
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
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  BackgroundFetch.stop().then((int status) {
                    print('[BackgroundFetch] stop success: $status');
                  });
                  prefs.remove('current_name');
                  prefs.remove('current_cpf');
                  prefs.remove('current_email');
                  prefs.remove('token');
                  prefs.remove('password');
                  prefs.remove('dispositivo_id');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
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
    await _studentsController.loadingStudents(widget.cpf, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    // _loadingAllStudents();

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Estudantes"),
        backgroundColor: Color(0xffEEC25E),
        automaticallyImplyLeading: false,
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
                      if (_studentsController.isLoading) {
                        return GFLoader(
                          type: GFLoaderType.square,
                          loaderColorOne: Color(0xffDE9524),
                          loaderColorTwo: Color(0xffC65D00),
                          loaderColorThree: Color(0xffC65D00),
                          size: GFSize.LARGE,
                        );
                      } else {
                        if (_studentsController.dataEstudent == null) {
                          return Container(
                              child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                "Erro ao carregar aluno",
                                maxFontSize: 18,
                                minFontSize: 16,
                              ),
                              Divider(
                                color: Color(0xffcecece),
                              )
                            ],
                          ));
                        } else {
                          return ListView.builder(
                            itemCount:
                                _studentsController.dataEstudent.data.length,
                            itemBuilder: (context, index) {
                              final dados =
                                  _studentsController.dataEstudent.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TagCustom(
                                      text: "${dados[index].grupo}",
                                      color: Color(0xffC65D00)),
                                  _listStudents(
                                      dados[index].students,
                                      context,
                                      dados[index].grupo,
                                      widget.token,
                                      dados[index].codigoGrupo),
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
