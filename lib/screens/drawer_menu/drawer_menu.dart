import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/enumeradores/modalidade_tipo.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/screens/calendar/list_events.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/terms/terms_use.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/ui/views/outros_servicos_lista.view.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/mensagem_sistema.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class DrawerMenu extends StatefulWidget {
  final EstudanteModel estudante;
  final int codigoGrupo;
  final int userId;
  final String groupSchool;

  DrawerMenu({required this.estudante, required this.codigoGrupo, required this.userId, required this.groupSchool});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final usuarioController = GetIt.I.get<UsuarioController>();

  late MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
  }

  _loadingBackRecentMessage() {
    _messagesController = MessagesController();
    _messagesController.loadMessages(
      widget.estudante.codigoEol,
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
          codigoAlunoEol: widget.estudante.codigoEol,
        ),
      ),
    ).whenComplete(() => _loadingBackRecentMessage());
  }

  navigateToListStudents(BuildContext context) async {
    if (usuarioStore.usuario != null) {
      Nav.push(context, EstudanteListaView());
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginView(
                    notice: '',
                  )));
    }
  }

  _navigateToTerms(BuildContext context) {
    Nav.push(context, TermsUse());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    var textoBotaoRelatorio = widget.codigoGrupo.toString() == ModalidadeTipo.EducacaoInfantil
        ? MensagemSistema.MenuLabelFrequenciaRelatorio
        : MensagemSistema.MenuLabelFrequenciaBoletim;
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
                    margin: EdgeInsets.only(right: screenHeight * 3, bottom: screenHeight * 3),
                    child: ClipOval(
                      child: Image.asset(
                        MensagemSistema.CaminhoImagemUsuario,
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
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      );
                    } else {
                      return AutoSizeText(
                        MensagemSistema.MenuLabelNaoCarregado,
                        maxFontSize: 16,
                        minFontSize: 14,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      );
                    }
                  }),
                  AutoSizeText(
                    MensagemSistema.MenuLabelStatusAtivo,
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
            title: Text(MensagemSistema.MenuLabelEstudantes),
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
            title: Text(MensagemSistema.MenuLabelMensagens),
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
            title: Text(textoBotaoRelatorio),
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
                  builder: (context) => EstudanteResumoView(
                    estudante: widget.estudante,
                    userId: widget.userId,
                    modalidade: widget.groupSchool,
                    grupoCodigo: widget.codigoGrupo.toString(),
                  ),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(MensagemSistema.MenuLabelAgenda),
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
                      builder: (context) => ListEvents(student: widget.estudante, userId: widget.userId)));
            },
          ),
          Divider(),
          ListTile(
            title: Text(MensagemSistema.MenuLabelMeusDados),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.slidersH,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () async {
              await usuarioController.obterDadosUsuario();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MeusDadosView()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(MensagemSistema.MenuLabelOutrosServicos),
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
            title: Text(MensagemSistema.MenuLabelOutrosServicos),
            leading: CircleAvatar(
              backgroundColor: Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.alignJustify,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutrosServicosLista(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(MensagemSistema.MenuLabelSairSistema),
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
