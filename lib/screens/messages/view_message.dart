import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';

class ViewMessage extends StatelessWidget {
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
                    "Próximas atualizações do app",
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
                    child: AutoSizeText(
                      "Em breve, você terá acesso aos dados do Boletim. Aguarde a próxima versão do aplicativo e atualize assim que estiver disponível. Em breve, você terá acesso aos dados do Boletim. Aguarde a próxima versão do aplicativo e atualize assim que estiver disponível. Em breve, você terá acesso aos dados do Boletim. Aguarde a próxima versão do aplicativo e atualize assim que estiver disponível. www.qualquerurl.com.br",
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xff666666),
                        height: screenHeight * 0.2,
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
                        FontAwesomeIcons.trashAlt,
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
                          Navigator.of(context).pop();
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
