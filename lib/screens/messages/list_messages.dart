import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';

import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:sme_app_aluno/utils/storage.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class ListMessages extends StatefulWidget {
  final String token;
  final int codigoGrupo;
  ListMessages({@required this.token, @required this.codigoGrupo});
  _ListMessageState createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessages> {
  MessagesController _messagesController;
  Storage storage;

  @override
  void initState() {
    super.initState();
    _messagesController = MessagesController();
    _messagesController.loadMessages(token: widget.token);
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
                  onPressed: () {
                    _removeMesageToStorage(id);
                    Navigator.of(context).pop(false);
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

  _removeMesageToStorage(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = [];
    String currentName = prefs.getString("current_name");
    String json = prefs.getString("${currentName}_deleted_id");
    if (json != null) {
      ids = jsonDecode(json).cast<String>();
    }
    ids.add(id.toString());
    prefs.setString("${currentName}_deleted_id", jsonEncode(ids));
  }

  Widget _listCardsMessages(List<Message> messages, BuildContext context,
      double screenHeight, String token) {
    return new Column(
        children: messages
            .where((e) => e.id != messages[0].id)
            .toList()
            .map((item) => CardMessage(
                  headerTitle: "ASSUNTO",
                  headerIcon: false,
                  recentMessage: !item.mensagemVisualizada,
                  content: <Widget>[
                    AutoSizeText(
                      item.titulo,
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 2,
                      style: TextStyle(
                          color: !item.mensagemVisualizada
                              ? Colors.white
                              : Color(0xff666666),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: screenHeight * 1.8,
                    ),
                    Container(
                      width: screenHeight * 41,
                      child: AutoSizeText(
                        StringSupport.parseHtmlString(
                            StringSupport.truncateEndString(
                                item.mensagem, 250)),
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: !item.mensagemVisualizada
                                ? Colors.white
                                : Color(0xff666666),
                            height: screenHeight * 0.240),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                    AutoSizeText(
                      DateFormatSuport.formatStringDate(
                          item.criadoEm, 'dd/MM/yyyy'),
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 2,
                      style: TextStyle(
                          color: !item.mensagemVisualizada
                              ? Colors.white
                              : Color(0xff666666),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                  footer: true,
                  footerContent: <Widget>[
                    GestureDetector(
                      onTap: () => _confirmDeleteMessage(item.id),
                      child: Container(
                        width: screenHeight * 6,
                        height: screenHeight * 6,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffC65D00), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 3),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.trashAlt,
                          color: Color(0xffC65D00),
                        ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewMessage(
                                          message: item,
                                          token: widget.token,
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "LER MENSAGEM",
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                    color: Color(0xffC65D00),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: screenHeight * 2,
                              ),
                              Icon(
                                FontAwesomeIcons.envelopeOpen,
                                color: Color(0xffffd037),
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
            .toList());
  }

  Widget _buildListMessages(
      BuildContext context, num screenHeight, String token) {
    return Observer(builder: (context) {
      if (_messagesController.isLoading) {
        return GFLoader(
          type: GFLoaderType.square,
          loaderColorOne: Color(0xffDE9524),
          loaderColorTwo: Color(0xffC65D00),
          loaderColorThree: Color(0xffC65D00),
          size: GFSize.LARGE,
        );
      } else {
        _messagesController.messagesPerGroups(widget.codigoGrupo);
        _messagesController.loadMessagesNotDeleteds();

        if (_messagesController.messagesNotDeleted == null ||
            _messagesController.messagesNotDeleted.isEmpty) {
          return Container(
              margin: EdgeInsets.only(top: screenHeight * 2.5),
              child: Visibility(
                visible: _messagesController.messagesNotDeleted != null &&
                    _messagesController.messagesNotDeleted.isEmpty,
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Nenhuma mensagem está disponível para este aluno",
                      maxFontSize: 18,
                      minFontSize: 16,
                    ),
                    Divider(
                      color: Color(0xffcecece),
                    )
                  ],
                ),
              ));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 3,
              ),
              AutoSizeText(
                "MENSAGEM MAIS RECENTE",
                maxFontSize: 18,
                minFontSize: 16,
                style: TextStyle(
                    color: Color(0xffDE9524), fontWeight: FontWeight.w500),
              ),
              CardMessage(
                headerTitle: "ASSUNTO",
                headerIcon: true,
                recentMessage: !_messagesController
                    .messagesNotDeleted.first.mensagemVisualizada,
                content: <Widget>[
                  AutoSizeText(
                    _messagesController.messagesNotDeleted.first.titulo,
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: TextStyle(
                        color: !_messagesController
                                .messagesNotDeleted.first.mensagemVisualizada
                            ? Colors.white
                            : Color(0xff666666),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: screenHeight * 1.8,
                  ),
                  Container(
                    width: screenHeight * 41,
                    child: AutoSizeText(
                      StringSupport.parseHtmlString(_messagesController
                          .messagesNotDeleted.first.mensagem),
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: !_messagesController
                                .messagesNotDeleted.first.mensagemVisualizada
                            ? Colors.white
                            : Color(0xff666666),
                        height: screenHeight * 0.240,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 3,
                  ),
                  AutoSizeText(
                    DateFormatSuport.formatStringDate(
                        _messagesController.messagesNotDeleted.first.criadoEm,
                        'dd/MM/yyyy'),
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: TextStyle(
                        color: !_messagesController
                                .messagesNotDeleted.first.mensagemVisualizada
                            ? Colors.white
                            : Color(0xff666666),
                        fontWeight: FontWeight.w700),
                  ),
                ],
                footer: true,
                footerContent: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _confirmDeleteMessage(
                          _messagesController.messagesNotDeleted.first.id);
                    },
                    child: Container(
                      width: screenHeight * 6,
                      height: screenHeight * 6,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC65D00), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 3),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.times,
                        color: Color(0xffC65D00),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      height: screenHeight * 6,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC65D00), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 3),
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMessage(
                                        token: token,
                                        message: _messagesController
                                            .messagesNotDeleted.first,
                                      )));
                        },
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              "LER MENSAGEM",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Color(0xffC65D00),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: screenHeight * 2,
                            ),
                            Icon(
                              FontAwesomeIcons.envelopeOpen,
                              color: Color(0xffffd037),
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 5,
              ),
              _messagesController.messagesNotDeleted.length == 1
                  ? Container()
                  : AutoSizeText(
                      (_messagesController.messagesNotDeleted.length - 1) == 1
                          ? "${_messagesController.messagesNotDeleted.length - 1} MENSAGEM ANTIGA"
                          : "${_messagesController.messagesNotDeleted.length - 1} MENSAGENS ANTIGAS",
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(
                          color: Color(0xffDE9524),
                          fontWeight: FontWeight.w500),
                    ),
              _listCardsMessages(_messagesController.messagesNotDeleted,
                  context, screenHeight, token)
            ],
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Mensagens"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _messagesController.loadMessages(token: widget.token);
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 2.5, vertical: screenHeight * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildListMessages(context, screenHeight, widget.token),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
