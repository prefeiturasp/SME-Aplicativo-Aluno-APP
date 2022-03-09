import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/outros_servicos_repository.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eaicon_button.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMessage extends StatefulWidget {
  final Message message;
  final int codigoAlunoEol;
  final int userId;

  ViewMessage(
      {@required this.message,
      @required this.codigoAlunoEol,
      @required this.userId});

  @override
  _ViewMessageState createState() => _ViewMessageState();
}

class _ViewMessageState extends State<ViewMessage> {
  MessagesController _messagesController;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  bool messageIsRead = true;

  @override
  void initState() {
    super.initState();
    _messagesController = MessagesController();
    _viewMessageUpdate(widget.message.mensagemVisualizada, false);
  }

  _viewMessageUpdate(bool mensagemVisualizada, bool action) async {
    if (!mensagemVisualizada && action) {
      _messagesController.updateMessage(
          notificacaoId: widget.message.id,
          usuarioId: widget.userId,
          codigoAlunoEol: widget.codigoAlunoEol ?? 0,
          mensagemVisualia: false);
    } else if (!mensagemVisualizada) {
      _messagesController.updateMessage(
          notificacaoId: widget.message.id,
          usuarioId: widget.userId,
          codigoAlunoEol: widget.codigoAlunoEol ?? 0,
          mensagemVisualia: true);
    }
  }

  Future<bool> _confirmDeleteMessage(int id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text("Você tem certeza que deseja excluir esta mensagem?"),
            actions: <Widget>[
              FlatButton(
                  child: Text("SIM"),
                  onPressed: () async {
                    await _removeMesageToStorage(
                      widget.codigoAlunoEol,
                      id,
                      widget.userId,
                    );
                    Navigator.of(context).pop(false);
                    Navigator.pop(context);
                  }),
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

  Future<bool> _confirmNotReadeMessage(int id, scaffoldKey) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text(
                "Você tem certeza que deseja marcar esta mensagem como não lida?"),
            actions: <Widget>[
              FlatButton(
                  child: Text("SIM"),
                  onPressed: () {
                    _viewMessageUpdate(false, true);
                    Navigator.of(context).pop(false);
                    var snackbar = SnackBar(
                        content: Text("Mensagem marcada como não lida"));
                    scaffoldKey.currentState.showSnackBar(snackbar);
                    setState(() {
                      messageIsRead = false;
                    });
                  }),
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

  _removeMesageToStorage(int codigoEol, int idNotificacao, int userId) async {
    await _messagesController.deleteMessage(codigoEol, idNotificacao, userId);
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      var codigo = _obterCodigoRelatorio(url);
      bool relatorioExiste = await _relatorioExiste(codigo);
      if (relatorioExiste) {
        await launch(url);
      } else {
        _modalInfo();
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _relatorioExiste(String codigo) async {
    final outroServicoRepositorio = OutrosServicosRepository();
    return await outroServicoRepositorio.verificarSeRelatorioExiste(codigo);
  }

  String _obterCodigoRelatorio(url) {
    final regexp = RegExp(
        r'[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}');
    return regexp.stringMatch(url);
  }

  _modalInfo() {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
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
                color: Color(0xffDADADA),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 1),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 3,
            ),
            AutoSizeText(
              "AVISO",
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Container(
              height: screenHeight * 20,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  AutoSizeText(
                    "O arquivo não está mais disponível, solicite a geração do relatório novamente.",
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xffd06d12),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          "ENTENDI",
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: TextStyle(
                              color: Color(0xffd06d12),
                              fontWeight: FontWeight.w700),
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
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      return NotInteernet();
    } else {
      var size = MediaQuery.of(context).size;
      var screenHeight =
          (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title: Text("Mensagens"),
          backgroundColor: Color(0xffEEC25E),
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
                AutoSizeText(
                  "MENSAGEM",
                  style: TextStyle(
                      color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                ),
                CardMessage(
                  headerTitle: widget.message.categoriaNotificacao,
                  headerIcon: false,
                  recentMessage: false,
                  categoriaNotificacao: widget.message.categoriaNotificacao,
                  content: <Widget>[
                    Container(
                      width: screenHeight * 39,
                      child: AutoSizeText(
                        widget.message.titulo,
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 5,
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 1.8,
                    ),
                    Container(
                      width: screenHeight * 39,
                      child: HtmlWidget(
                        widget.message.mensagem,
                        onTapUrl: (url) => _launchURL(url),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                    AutoSizeText(
                      DateFormatSuport.formatStringDate(
                          widget.message.criadoEm, 'dd/MM/yyyy'),
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 2,
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                  footer: true,
                  footerContent: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          EAIconButton(
                            iconBtn: Icon(
                              FontAwesomeIcons.trashAlt,
                              color: Color(0xffC65D00),
                            ),
                            screenHeight: screenHeight,
                            onPress: () =>
                                _confirmDeleteMessage(widget.message.id),
                          ),
                          SizedBox(
                            width: screenHeight * 2,
                          ),
                          Visibility(
                            visible: messageIsRead,
                            child: EAIconButton(
                                iconBtn: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Color(0xffC65D00),
                                ),
                                screenHeight: screenHeight,
                                onPress: () => _confirmNotReadeMessage(
                                    widget.message.id, scaffoldKey)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        height: screenHeight * 6,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffC65D00), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 3),
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "VOLTAR",
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                    color: Color(0xffC65D00),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: screenHeight * 1,
                              ),
                              Icon(
                                FontAwesomeIcons.angleLeft,
                                color: Color(0xffffd037),
                                size: screenHeight * 4,
                              )
                            ],
                          ),
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
