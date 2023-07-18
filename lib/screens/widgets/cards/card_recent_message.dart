import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class CardRecentMessage extends StatefulWidget {
  final Message message;
  final int countMessages;
  final String token;
  final int codigoGrupo;
  final bool deleteBtn;
  final bool recent;
  final VoidCallback onPress;
  final Function outherRoutes;

  CardRecentMessage(
      {this.message,
      this.countMessages,
      this.token,
      this.codigoGrupo,
      this.outherRoutes,
      this.deleteBtn = true,
      this.recent = false,
      this.onPress});

  @override
  _CardRecentMessageState createState() => _CardRecentMessageState();
}

class _CardRecentMessageState extends State<CardRecentMessage> {
  Future<bool> _confirmDeleteMessage(int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text("Você tem certeza que deseja excluir esta mensagem?"),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("SIM"),
                  onPressed: () {
                    // _removeMesageToStorage(id);
                  }),
              ElevatedButton(
                child: Text("NÃO"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

  _removeMesageToStorage(int id) async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: widget.message == null ? Color(0xffC45C04) : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            decoration: BoxDecoration(
                color: widget.recent ? Color(0xffE1771D) : Color(0xffF8E8C2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2), topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: screenHeight * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          widget.recent ? FontAwesomeIcons.envelope : FontAwesomeIcons.envelopeOpen,
                          color: widget.recent ? Color(0xffFFD037) : Color(0xffE1771D),
                          size: screenHeight * 2.7,
                        ),
                        SizedBox(
                          width: screenHeight * 1.5,
                        ),
                        AutoSizeText(
                          "MENSAGEM MAIS RECENTE",
                          maxFontSize: 18,
                          minFontSize: 16,
                          style: TextStyle(
                              color: widget.recent ? Colors.white : Color(0xffE1771D), fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                Visibility(
                  visible: widget.countMessages != null && widget.countMessages > 0,
                  child: Stack(overflow: Overflow.visible, children: <Widget>[
                    Container(
                      width: screenHeight * 3.5,
                      height: screenHeight * 3.5,
                      decoration: BoxDecoration(
                        color: Color(0xfffac635),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 1.750),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.envelopeOpen,
                        color: Color(0xffC65D00),
                        size: 10,
                      ),
                    ),
                    Positioned(
                      top: -10.0,
                      right: 0.0,
                      child: Container(
                          width: screenHeight * 3,
                          height: screenHeight * 3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 1.5),
                            ),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "${widget.countMessages}",
                              maxFontSize: 12,
                              minFontSize: 10,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffC45C04)),
                            ),
                          )),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.message != null) {
                widget.onPress();
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(screenHeight * 2.5),
                color: widget.recent ? Color(0xffC45C04) : Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 1.8),
                  child: widget.message != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              widget.message.titulo,
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 2,
                              style: TextStyle(
                                  color: widget.recent ? Colors.white : Color(0xff666666), fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: screenHeight * 1.8,
                            ),
                            Container(
                              width: screenHeight * 36,
                              child: AutoSizeText(
                                StringSupport.parseHtmlString(
                                    StringSupport.truncateEndString(widget.message.mensagem, 250)),
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: widget.recent ? Colors.white : Color(0xff666666),
                                ),
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
                              style: TextStyle(
                                  color: widget.recent ? Colors.white : Color(0xff666666),
                                  fontWeight: FontWeight.w700,
                                  height: screenHeight * 0.5),
                            ),
                          ],
                        )
                      : AutoSizeText(
                          "Nenhuma mensagem está disponível para este aluno",
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                )),
          ),
          Container(
              decoration: BoxDecoration(
                  color: widget.message != null && widget.countMessages > 0
                      ? widget.recent
                          ? null
                          : Color(0xffF3F3F3)
                      : Color(0xffC45C04),
                  borderRadius: widget.message != null && widget.countMessages > 0
                      ? widget.recent
                          ? null
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(screenHeight * 2),
                              bottomRight: Radius.circular(screenHeight * 2),
                            )
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(screenHeight * 2),
                          bottomRight: Radius.circular(screenHeight * 2),
                        )),
              padding: EdgeInsets.only(
                  left: screenHeight * 2.5,
                  right: screenHeight * 2.5,
                  top: screenHeight * 1.5,
                  bottom: screenHeight * 1.5),
              child: widget.message != null && widget.countMessages > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                          visible: widget.deleteBtn,
                          child: GestureDetector(
                            onTap: () {
                              _confirmDeleteMessage(widget.message.id);
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
                            child: ElevatedButton(
                              onPressed: widget.outherRoutes,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    "VER TODAS",
                                    maxFontSize: 16,
                                    minFontSize: 14,
                                    style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: screenHeight * 2,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.envelopeOpen,
                                    color: Color(0xffffd037),
                                    size: screenHeight * 3,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()),
        ],
      ),
    );
  }
}
