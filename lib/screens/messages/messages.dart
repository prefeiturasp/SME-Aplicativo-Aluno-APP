import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';

class Messages extends StatelessWidget {
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
                "MENSAGEM MAIS RECENTE",
                style: TextStyle(
                    color: Color(0xffDE9524), fontWeight: FontWeight.w500),
              ),
              CardMessage(
                headerTitle: "ASSUNTO",
                headerIcon: true,
                recentMessage: true,
                content: <Widget>[
                  AutoSizeText(
                    "Próximas atualizações do app",
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: screenHeight * 1.8,
                  ),
                  Container(
                    width: screenHeight * 41,
                    child: AutoSizeText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consectetur felis quis imperdiet congue. Suspendisse hendrerit placerat orci.",
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 3,
                  ),
                ],
                footer: true,
                footerContent: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: screenHeight * 7,
                      height: screenHeight * 7,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC65D00), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 3.5),
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
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC65D00), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 4),
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMessage()));
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
                              size: screenHeight * 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 6,
              ),
              AutoSizeText(
                "1 MENSAGEM ANTIGA",
                style: TextStyle(
                    color: Color(0xffDE9524), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenHeight * 3,
              ),
              Container(
                height: screenHeight * 74,
                child: ListView(
                  children: <Widget>[
                    CardMessage(
                      headerTitle: "ASSUNTO   ",
                      headerIcon: false,
                      recentMessage: false,
                      content: <Widget>[
                        AutoSizeText(
                          "Próximas atualizações do app",
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 2,
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: screenHeight * 1.8,
                        ),
                        Container(
                          width: screenHeight * 41,
                          child: AutoSizeText(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consectetur felis quis imperdiet congue. Suspendisse hendrerit placerat orci.",
                            maxFontSize: 16,
                            minFontSize: 14,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff666666),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 3,
                        ),
                      ],
                      footer: true,
                      footerContent: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: screenHeight * 7,
                            height: screenHeight * 7,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffC65D00), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight * 3.5),
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
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffC65D00), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight * 4),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewMessage()));
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
                                    size: screenHeight * 3,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
