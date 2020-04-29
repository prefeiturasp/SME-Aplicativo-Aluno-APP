import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/utils/date_format.dart';

class ViewMessage extends StatelessWidget {
  final Message message;
  final String token;

  ViewMessage({@required this.message, @required this.token});

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
                headerTitle: "ASSUNTO",
                headerIcon: false,
                recentMessage: false,
                content: <Widget>[
                  AutoSizeText(
                    message.titulo,
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: TextStyle(
                        color: Color(0xff666666), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: screenHeight * 1.8,
                  ),
                  Container(
                    width: screenHeight * 41,
                    child: Html(
                      data: message.mensagem,
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
                        color: Color(0xff666666), fontWeight: FontWeight.w700),
                  ),
                ],
                footer: true,
                footerContent: <Widget>[
                  GestureDetector(
                    onTap: () {},
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
                        FontAwesomeIcons.trashAlt,
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
