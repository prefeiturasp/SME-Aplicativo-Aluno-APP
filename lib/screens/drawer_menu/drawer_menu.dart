import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/calendar/list_events.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/views/login.view.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/settings/settings.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/students/resume_studants/resume_studants.dart';
import 'package:sme_app_aluno/screens/terms/terms_use.dart';
import 'package:sme_app_aluno/ui/views/meus_dados.view.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class DrawerMenu extends StatefulWidget {
  final Student student;
  final int codigoGrupo;
  final int userId;
  final String groupSchool;

  DrawerMenu(
      {@required this.student,
      @required this.codigoGrupo,
      @required this.userId,
      @required this.groupSchool});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
  }

  _loadingBackRecentMessage() {
    _messagesController = MessagesController();
    _messagesController.loadMessages(
      widget.student.codigoEol,
      usuarioStore.usuario.id,
    );
  }

  navigateToListMessages(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListMessages(
                userId: usuarioStore.usuario.id,
                codigoGrupo: widget.codigoGrupo,
                codigoAlunoEol: widget.student.codigoEol,
              )),
    ).whenComplete(() => _loadingBackRecentMessage());
  }

  navigateToListStudents(BuildContext context) async {
    if (usuarioStore.usuario != null) {
      Nav.push(
          context,
          ListStudants(
            userId: usuarioStore.usuario.id,
          ));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    }
  }

  _navigateToSettings(BuildContext context) async {
    Nav.push(
        context,
        Settings(
          currentCPF: usuarioStore.usuario.cpf,
          email: usuarioStore.usuario.email,
          phone: usuarioStore.usuario.celular,
          userId: usuarioStore.usuario.id,
        ));
  }

  _navigateToTerms(BuildContext context) {
    Nav.push(context, TermsUse());
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
                    if (usuarioStore.usuario != null) {
                      return AutoSizeText(
                        "${usuarioStore.usuario.nome}",
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
                            userId: widget.userId,
                            groupSchool: widget.groupSchool,
                          )));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Agenda'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListEvents(
                          student: widget.student, userId: widget.userId)));
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MeusDadosView()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Termos de Uso'),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.fileAlt,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              _navigateToTerms(context);
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
              Auth.logout(context, usuarioStore.usuario.id, false);
            },
          ),
        ],
      ),
    );
  }
}
