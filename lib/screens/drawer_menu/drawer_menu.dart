import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/controllers/auth/authenticate.controller.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/settings/settings.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/students/resume_studants/resume_studants.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class DrawerMenu extends StatefulWidget {
  final Student student;
  final int codigoGrupo;
  final int userId;

  DrawerMenu(
      {@required this.student,
      @required this.codigoGrupo,
      @required this.userId});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  AuthenticateController _authenticateController;
  MessagesController _messagesController;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _authenticateController = AuthenticateController();
  }

  _loadingBackRecentMessage() {
    _messagesController = MessagesController();
    _messagesController.loadMessages(
      widget.student.codigoEol,
      widget.userId,
    );
  }

  navigateToListMessages(BuildContext context) async {
    Nav.push(
        context,
        ListMessages(
          userId: widget.userId,
          codigoGrupo: widget.codigoGrupo,
          codigoAlunoEol: widget.student.codigoEol,
        )).whenComplete(() => _loadingBackRecentMessage());
  }

  navigateToListStudents(BuildContext context) async {
    final User user = await _userService.find(widget.userId);

    if (user != null) {
      Nav.push(
          context,
          ListStudants(
            userId: user.id,
            password: "_password",
          ));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  _navigateToSettings(BuildContext context) async {
    final User user = await _userService.find(widget.userId);
    Nav.push(
        context,
        Settings(
          currentCPF: user.cpf,
          email: user.email,
          phone: user.celular,
        ));
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
              // radius: screenHeight * 2,
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              navigateToListStudents(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Mensagens'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.envelopeOpen,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              navigateToListMessages(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Frequência / Boletim'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.copy,
                color: Colors.white,
                size: screenHeight * 2,
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
          Divider(),
          ListTile(
            title: Text('Meus Dados'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.slidersH,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              _navigateToSettings(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Sair'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () async {
              final User user = await _userService.find(2);
              BackgroundFetch.stop().then((int status) {
                print('[BackgroundFetch] stop success: $status');
              });
              Auth.logout(context, user.id);
            },
          ),
        ],
      ),
    );
  }
}
