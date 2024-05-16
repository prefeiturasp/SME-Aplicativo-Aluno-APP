import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/messages/messages.controller.dart';
import '../../models/message/message.dart';
import '../../repositories/outros_servicos_repository.dart';
import '../../utils/conection.dart';
import '../../utils/date_format.dart';
import '../not_internet/not_internet.dart';
import '../widgets/buttons/eaicon_button.dart';
import '../widgets/cards/index.dart';

class ViewMessage extends StatefulWidget {
  final Message message;
  final int codigoAlunoEol;
  final int userId;

  const ViewMessage({super.key, required this.message, required this.codigoAlunoEol, required this.userId});

  @override
  ViewMessageState createState() => ViewMessageState();
}

class ViewMessageState extends State<ViewMessage> {
  final MessagesController _messagesController = MessagesController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool messageIsRead = true;

  @override
  void initState() {
    super.initState();
    viewMessageUpdate(widget.message.mensagemVisualizada);
  }

  Future<void> viewMessageUpdate(bool mensagemVisualizada) async {
    _messagesController.updateMessage(
      notificacaoId: widget.message.id,
      usuarioId: widget.userId,
      codigoAlunoEol: widget.codigoAlunoEol,
      mensagemVisualia: mensagemVisualizada,
    );
  }

  Future<bool> confirmDeleteMessage(int id) async {
    bool retorno = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você tem certeza que deseja excluir esta mensagem?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () async {
                retorno = true;
                await removeMesageToStorage(
                  widget.codigoAlunoEol,
                  id,
                  widget.userId,
                );
                if (context.mounted) {
                  Navigator.of(context).pop(false);
                  Navigator.pop(context);
                }
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                retorno = false;
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );

    return retorno;
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
                viewMessageUpdate(!mensagem.mensagemVisualizada);
                Navigator.of(context).pop(false);
                final snackbar = SnackBar(content: Text('Mensagem marcada como $msg '));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                setState(() {
                  messageIsRead = false;
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

  Future<void> removeMesageToStorage(int codigoEol, int idNotificacao, int userId) async {
    await _messagesController.deleteMessage(codigoEol, idNotificacao, userId);
  }

  Future<bool> launchURL(url) async {
    final Uri uri = Uri.parse(url);
    final codigo = _obterCodigoRelatorio(url);
    final bool relatorioExiste = await _relatorioExiste(codigo);
    if (relatorioExiste) {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        showInfo(Colors.red, 'Falha ao Abrir o LINK');
      }
      return true;
    } else {
      _modalInfo();
      return false;
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

  Future<bool> _relatorioExiste(String codigo) async {
    final outroServicoRepositorio = OutrosServicosRepository();
    return await outroServicoRepositorio.verificarSeRelatorioExiste(codigo);
  }

  String _obterCodigoRelatorio(String url) {
    final regexp = RegExp(r'[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}');
    return regexp.stringMatch(url) ?? '';
  }

  Future _modalInfo() {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenHeight * 8),
            topLeft: Radius.circular(screenHeight * 8),
          ),
          color: Colors.white,
        ),
        height: screenHeight * 30,
        child: Column(
          children: [
            Container(
              width: screenHeight * 8,
              height: screenHeight * 1,
              margin: EdgeInsets.only(top: screenHeight * 2),
              decoration: BoxDecoration(
                color: const Color(0xffDADADA),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 1),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 3,
            ),
            const AutoSizeText(
              'AVISO',
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
            Container(
              height: screenHeight * 20,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const AutoSizeText(
                    'O arquivo não está mais disponível, solicite a geração do relatório novamente.',
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(0xffd06d12),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          'ENTENDI',
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: TextStyle(color: Color(0xffd06d12), fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  headerIcon: false,
                  recentMessage: false,
                  categoriaNotificacao: widget.message.categoriaNotificacao,
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
                        onTapUrl: (url) => launchURL(url),
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
                        EAIconButton(
                          iconBtn: const Icon(
                            FontAwesomeIcons.trashCan,
                            color: Color(0xffC65D00),
                          ),
                          screenHeight: screenHeight,
                          onPress: () => confirmDeleteMessage(widget.message.id),
                        ),
                        SizedBox(
                          width: screenHeight * 2,
                        ),
                        Visibility(
                          visible: messageIsRead,
                          child: EAIconButton(
                            iconBtn: Icon(
                              widget.message.mensagemVisualizada
                                  ? FontAwesomeIcons.envelopeOpen
                                  : FontAwesomeIcons.envelope,
                              color: const Color(0xffC65D00),
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
                        onPressed: () {
                          Navigator.pop(context);
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
