import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class CardRecentMessage extends StatelessWidget {
  final Message message;
  final int countMessages;
  final String token;
  final int codigoGrupo;

  CardRecentMessage(
      {this.message, this.countMessages, this.token, this.codigoGrupo});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: message == null ? Color(0xffC45C04) : Colors.white,
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
                color: Color(0xffE1771D),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: screenHeight * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.envelopeOpen,
                          color: Color(0xffFFD037),
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
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                Visibility(
                  visible: countMessages != null && countMessages > 0,
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
                              "$countMessages",
                              maxFontSize: 12,
                              minFontSize: 10,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffC45C04)),
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
              message != null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewMessage(message: message, token: token)))
                  : () => {};
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(screenHeight * 2.5),
                color: Color(0xffC45C04),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 1.8),
                  child: message != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              message.titulo,
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: screenHeight * 1.8,
                            ),
                            Container(
                              width: screenHeight * 36,
                              child: AutoSizeText(
                                StringSupport.parseHtmlString(
                                    StringSupport.truncateEndString(
                                        message.mensagem, 250)),
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 3,
                            ),
                            AutoSizeText(
                              DateFormatSuport.formatStringDate(
                                  message.criadoEm, 'dd/MM/yyyy'),
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
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
                  color: message != null && countMessages > 0
                      ? null
                      : Color(0xffC45C04),
                  borderRadius: message != null && countMessages > 0
                      ? null
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(screenHeight * 2),
                          bottomRight: Radius.circular(screenHeight * 2),
                        )),
              padding: EdgeInsets.only(
                  left: screenHeight * 2.5,
                  right: screenHeight * 2.5,
                  top: screenHeight * 1.5,
                  bottom: screenHeight * 1.5),
              child: message != null && countMessages > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListMessages(
                                            token: token,
                                            codigoGrupo: codigoGrupo)));
                              },
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
