import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/index.dart';
import '../../controllers/messages/messages.controller.dart';
import '../../enumeradores/modalidade_tipo.dart';
import '../../models/estudante.model.dart';
import '../../stores/index.dart';
import '../../ui/index.dart';
import '../../ui/views/outros_servicos_lista.view.dart';
import '../../utils/auth.dart';
import '../../utils/mensagem_sistema.dart';
import '../../utils/navigator.dart';
import '../calendar/list_events.dart';
import '../messages/list_messages.dart';
import '../terms/terms_use.dart';

class DrawerMenu extends StatefulWidget {
  final EstudanteModel estudante;
  final int codigoGrupo;
  final int userId;
  final String groupSchool;

  const DrawerMenu({
    super.key,
    required this.estudante,
    required this.codigoGrupo,
    required this.userId,
    required this.groupSchool,
  });
  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final usuarioController = GetIt.I.get<UsuarioController>();

  final MessagesController _messagesController = MessagesController();

  @override
  void initState() {
    super.initState();
  }

  void loadingBackRecentMessage() {
    _messagesController.loadMessages(
      widget.estudante.codigoEol,
      usuarioStore.usuario!.id,
    );
  }

  void navigateToListMessages(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListMessages(
          userId: usuarioStore.usuario!.id,
          codigoGrupo: widget.codigoGrupo,
          codigoAlunoEol: widget.estudante.codigoEol,
        ),
      ),
    ).whenComplete(() => loadingBackRecentMessage());
  }

  void navigateToListStudents(BuildContext context) async {
    if (usuarioStore.usuario?.nome != null) {
      Nav.push(context, const EstudanteListaView());
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(
            notice: null,
          ),
        ),
      );
    }
  }

  void navigateToTerms(BuildContext context) {
    Nav.push(context, const TermsUse());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    final textoBotaoRelatorio = widget.codigoGrupo.toString() == ModalidadeTipo.EducacaoInfantil
        ? MensagemSistema.menuLabelFrequenciaRelatorio
        : MensagemSistema.menuLabelFrequenciaBoletim;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: screenHeight * 30,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: screenHeight * 3, bottom: screenHeight * 2),
                    child: ClipOval(
                      child: Image.asset(
                        MensagemSistema.caminhoImagemUsuario,
                        width: screenHeight * 8,
                        height: screenHeight * 8,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      if (usuarioStore.usuario?.nome != null) {
                        return AutoSizeText(
                          usuarioStore.usuario!.nome,
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        );
                      } else {
                        return const AutoSizeText(
                          MensagemSistema.menuLabelNaoCarregado,
                          maxFontSize: 16,
                          minFontSize: 14,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        );
                      }
                    },
                  ),
                  const AutoSizeText(
                    MensagemSistema.menuLabelStatusAtivo,
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: TextStyle(color: Color(0xffC4C4C4)),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(MensagemSistema.menuLabelEstudantes),
            leading: CircleAvatar(
              // radius: screenHeight * 2,
              backgroundColor: const Color(0xffEA9200),
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
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelMensagens),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
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
          const Divider(),
          ListTile(
            title: Text(textoBotaoRelatorio),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
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
                    modalidade: widget.groupSchool,
                    grupoCodigo: widget.codigoGrupo.toString(),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelAgenda),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.calendarDays,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListEvents(student: widget.estudante, userId: widget.userId),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelMeusDados),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.sliders,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () async {
              await usuarioController.obterDadosUsuario();
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MeusDadosView()),
                );
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelTermoUso),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.fileLines,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () {
              navigateToTerms(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelOutrosServicos),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
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
                  builder: (context) => const OutrosServicosLista(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(MensagemSistema.menuLabelSairSistema),
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEA9200),
              child: Icon(
                FontAwesomeIcons.rightFromBracket,
                color: Colors.white,
                size: screenHeight * 2,
              ),
            ),
            onTap: () async {
              Auth.logout(context, usuarioStore.usuario!.id, false);
            },
          ),
        ],
      ),
    );
  }
}
