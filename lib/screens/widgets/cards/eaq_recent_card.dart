import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class EAQRecentCardMessage extends StatefulWidget {
  final Message message;
  final int countMessages;
  final String token;
  final int codigoGrupo;
  final bool deleteBtn;
  final bool recent;
  final Function onPress;
  final Function outherRoutes;
  final int totalCateories;

  EAQRecentCardMessage(
      {this.message,
      this.countMessages,
      this.token,
      this.codigoGrupo,
      this.outherRoutes,
      this.deleteBtn = true,
      this.recent = false,
      this.onPress,
      @required this.totalCateories});

  @override
  _EAQRecentCardMessageState createState() => _EAQRecentCardMessageState();
}

class _EAQRecentCardMessageState extends State<EAQRecentCardMessage> {
  Future<bool> _confirmDeleteMessage(int id) {
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

  _removeMesageToStorage(int id) async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorSME = Color(0xff9C33AD);
    const colorUE = Color(0xff5151CF);
    const colorDRE = Color(0xff599E00);
    return Container(
      width: widget.totalCateories == 1
          ? MediaQuery.of(context).size.width
          : screenHeight * 40,
      margin: EdgeInsets.only(
        top: screenHeight * 1,
        right: widget.totalCateories == 1 ? 0.0 : screenHeight * 1.5,
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(screenHeight * 1.9),
            decoration: BoxDecoration(
                color: widget.message.categoriaNotificacao == "SME"
                    ? widget.recent
                        ? colorSME
                        : colorSME.withOpacity(0.4)
                    : widget.message.categoriaNotificacao == "UE"
                        ? widget.recent
                            ? colorUE
                            : colorUE.withOpacity(0.4)
                        : widget.recent
                            ? colorDRE
                            : colorDRE.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      widget.recent
                          ? FontAwesomeIcons.envelope
                          : FontAwesomeIcons.envelopeOpen,
                      color: widget.recent
                          ? Color(0xffFFD037)
                          : widget.message.categoriaNotificacao == "SME"
                              ? colorSME
                              : widget.message.categoriaNotificacao == "UE"
                                  ? colorUE
                                  : colorDRE,
                      size: screenHeight * 2.3,
                    ),
                    SizedBox(
                      width: screenHeight * 1.5,
                    ),
                    AutoSizeText(
                      widget.message.categoriaNotificacao,
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(
                          color: widget.recent
                              ? Colors.white
                              : widget.message.categoriaNotificacao == "SME"
                                  ? colorSME
                                  : widget.message.categoriaNotificacao == "UE"
                                      ? colorUE
                                      : colorDRE,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )),
                Visibility(
                  visible:
                      widget.countMessages != null && widget.countMessages > 0,
                  child: Stack(overflow: Overflow.visible, children: <Widget>[
                    Container(
                      width: screenHeight * 3.2,
                      height: screenHeight * 3.2,
                      decoration: BoxDecoration(
                        color: widget.recent
                            ? Color(0xffFFCF00)
                            : widget.message.categoriaNotificacao == "SME"
                                ? colorSME
                                : widget.message.categoriaNotificacao == "UE"
                                    ? colorUE
                                    : colorDRE,
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 1.750),
                        ),
                      ),
                      child: Icon(
                        widget.recent
                            ? FontAwesomeIcons.envelope
                            : FontAwesomeIcons.envelopeOpen,
                        color: !widget.recent
                            ? Color(0xffffffff)
                            : Color(0xffC65D00),
                        size: 10,
                      ),
                    ),
                    Positioned(
                      top: -8.0,
                      right: 0.0,
                      child: Container(
                          width: screenHeight * 2.5,
                          height: screenHeight * 2.5,
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.message.categoriaNotificacao ==
                                          "SME"
                                      ? colorSME
                                      : widget.message.categoriaNotificacao ==
                                              "UE"
                                          ? colorUE
                                          : colorDRE),
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
                height: screenHeight * 28.3,
                padding: EdgeInsets.all(screenHeight * 2),
                color: Colors.white,
                child: Container(
                  child: widget.message != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 3),
                              child: AutoSizeText(
                                widget.message.titulo,
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: screenHeight * 36,
                              child: AutoSizeText(
                                StringSupport.parseHtmlString(
                                    StringSupport.truncateEndString(
                                        widget.message.mensagem, 150)),
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xff666666),
                                ),
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
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                )),
          ),
          Container(
              decoration: BoxDecoration(
                  color: widget.message != null && widget.countMessages > 0
                      ? Color(0xffF3F3F3)
                      : Color(0xffC45C04),
                  borderRadius:
                      widget.message != null && widget.countMessages > 0
                          ? BorderRadius.only(
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
                                border: Border.all(
                                    color: Color(0xffC65D00), width: 1),
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
                              border: Border.all(
                                  color: Color(0xffC65D00), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight * 3),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: widget.outherRoutes,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    "VER TODAS",
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
