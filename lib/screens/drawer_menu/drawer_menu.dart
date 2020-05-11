import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/students/resume_studants/resume_studants.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class DrawerMenu extends StatefulWidget {
  final Student student;
  final int codigoGrupo;
  DrawerMenu({@required this.student, @required this.codigoGrupo});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final Storage _storage = Storage();

  AuthenticateController _authenticateController;

  @override
  void initState() {
    super.initState();
    _authenticateController = AuthenticateController();
  }

  navigateToListMessages(BuildContext context, Storage storage) async {
    var _token = await storage.readValueStorage("token") ?? "";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListMessages(
                  token: _token,
                  codigoGrupo: widget.codigoGrupo,
                )));
  }

  navigateToListStudents(BuildContext context, Storage storage) async {
    var _cpf = await storage.readValueStorage("current_cpf") ?? "";
    var _token = await storage.readValueStorage("token") ?? "";
    var _password = await storage.readValueStorage("current_password") ?? "";
    bool isCurrentUser = await storage.containsKey("current_cpf");
    if (isCurrentUser) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListStudants(
                    cpf: _cpf,
                    token: _token,
                    password: _password,
                  )));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BackgroundFetch.stop().then((int status) {
      print('[BackgroundFetch] stop success: $status');
    });
    prefs.remove('current_name');
    prefs.remove('current_cpf');
    prefs.remove('current_email');
    prefs.remove('token');
    prefs.remove('password');
    prefs.remove('dispositivo_id');
    prefs.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: screenHeight * 30,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        right: screenHeight * 3, bottom: screenHeight * 3),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/avatar_estudante.png",
                        width: screenHeight * 8,
                        height: screenHeight * 8,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Observer(builder: (context) {
                    if (_authenticateController.currentName != null) {
                      return AutoSizeText(
                        "${_authenticateController.currentName}",
                        maxFontSize: 16,
                        minFontSize: 14,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      );
                    } else {
                      return AutoSizeText(
                        "Não carregado",
                        maxFontSize: 16,
                        minFontSize: 14,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      );
                    }
                  }),
                  AutoSizeText(
                    "Usuário Ativo",
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: TextStyle(color: Color(0xffC4C4C4)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text('Estudantes'),
            leading: CircleAvatar(
              radius: screenHeight * 2,
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.white,
                size: screenHeight * 2.3,
              ),
            ),
            onTap: () {
              navigateToListStudents(context, _storage);
            },
          ),
          ListTile(
            title: Text('Mensagens'),
            leading: CircleAvatar(
              radius: screenHeight * 2,
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.envelopeOpen,
                color: Colors.white,
                size: screenHeight * 2.3,
              ),
            ),
            onTap: () {
              navigateToListMessages(context, _storage);
            },
          ),
          ListTile(
            title: Text('Frequência / Boletim'),
            leading: CircleAvatar(
              radius: screenHeight * 2,
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.copy,
                color: Colors.white,
                size: screenHeight * 2.3,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumeStudants(
                            student: widget.student,
                          )));
            },
          ),
          ListTile(
            title: Text('Sair'),
            leading: CircleAvatar(
              radius: screenHeight * 2,
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
                size: screenHeight * 2.5,
              ),
            ),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}
