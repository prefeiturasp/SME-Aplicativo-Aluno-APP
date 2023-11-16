import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/messages/messages.controller.dart';
import '../../models/message/message.dart';
import '../../stores/index.dart';
import '../../ui/views/estudante_lista.view.dart';
import '../../utils/conection.dart';
import '../../utils/date_format.dart';
import '../../utils/navigator.dart';
import '../not_internet/not_internet.dart';
import '../widgets/buttons/eaicon_button.dart';
import '../widgets/cards/index.dart';

class ViewMessageNotification extends StatefulWidget {
  final Message message;
  final int userId;

  const ViewMessageNotification({super.key, required this.message, required this.userId});

  @override
  ViewMessageNotificationState createState() => ViewMessageNotificationState();
}

class ViewMessageNotificationState extends State<ViewMessageNotification> {
  final MessagesController _messagesController = MessagesController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool messageIsRead = true;
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  void initState() {
    super.initState();
    _viewMessageUpdate(false, false);
  }

  void _viewMessageUpdate(bool isNotRead, bool action) async {
    if (action) {
      _messagesController.updateMessage(
        notificacaoId: widget.message.id,
        usuarioId: widget.userId,
        codigoAlunoEol: widget.message.codigoEOL,
        mensagemVisualia: false,
      );
    } else {
      _messagesController.updateMessage(
        notificacaoId: widget.message.id,
        usuarioId: widget.userId,
        codigoAlunoEol: widget.message.codigoEOL,
        mensagemVisualia: true,
      );
    }
  }

  Future<void> navigateToListMessage() async {
    Nav.push(context, const EstudanteListaView());
  }

  Future<void> confirmNotReadeMessage(Message mensagem, scaffoldKey) async {
    final String msg = mensagem.mensagemVisualizada ? 'não lida' : 'lida';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text('Você tem certeza que deseja marcar esta mensagem  como $msg ?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                _viewMessageUpdate(true, true);
                Navigator.of(context).pop(false);
                final snackbar = SnackBar(content: Text('Mensagem marcada como  $msg '));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                setState(() {
                  messageIsRead = !messageIsRead;
                });
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> openURl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showInfo(Colors.red, 'Falha ao Abrir o LINK');
    }
  }

  void showInfo(Color color, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(mensagem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.offline) {
      return const NotInteernet();
    } else {
      final size = MediaQuery.of(context).size;
      final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xffE5E5E5),
        appBar: AppBar(
          title: const Text('Mensagens'),
          backgroundColor: const Color(0xffEEC25E),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigateToListMessage();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 2.5,
                ),
                const AutoSizeText(
                  'MENSAGEM',
                  style: TextStyle(color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                ),
                CardMessage(
                  headerTitle: widget.message.categoriaNotificacao,
                  categoriaNotificacao: widget.message.categoriaNotificacao,
                  headerIcon: false,
                  recentMessage: false,
                  content: <Widget>[
                    SizedBox(
                      width: screenHeight * 39,
                      child: AutoSizeText(
                        widget.message.titulo,
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 5,
                        style: const TextStyle(color: Color(0xff666666), fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 1.8,
                    ),
                    SizedBox(
                      width: screenHeight * 39,
                      child: HtmlWidget(
                        widget.message.mensagem,
                        onTapUrl: (url) {
                          openURl(url);
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                    AutoSizeText(
                      DateFormatSuport.formatStringDate(widget.message.criadoEm, 'dd/MM/yyyy'),
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 2,
                      style: const TextStyle(color: Color(0xff666666), fontWeight: FontWeight.w700),
                    ),
                  ],
                  footer: true,
                  footerContent: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenHeight * 2,
                        ),
                        Visibility(
                          visible: messageIsRead,
                          child: EAIconButton(
                            iconBtn: const Icon(
                              FontAwesomeIcons.envelope,
                              color: Color(0xffC65D00),
                            ),
                            screenHeight: screenHeight,
                            onPress: () {
                              confirmNotReadeMessage(widget.message, scaffoldKey);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight * 6,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffC65D00), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 3),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          navigateToListMessage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF2F1EE),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenHeight * 3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const AutoSizeText(
                              'VOLTAR',
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: screenHeight * 1,
                            ),
                            Icon(
                              FontAwesomeIcons.angleLeft,
                              color: const Color(0xffffd037),
                              size: screenHeight * 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
