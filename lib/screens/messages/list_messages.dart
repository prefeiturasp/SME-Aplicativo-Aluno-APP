import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';

import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/utils/date_format.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class ListMessages extends StatefulWidget {
  final String token;

  ListMessages({@required this.token});
  _ListMessageState createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessages> {
  MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
    _messagesController = MessagesController();
    _messagesController.loadMessages(token: widget.token);
  }

  Widget _cardItems(BuildContext context, Message message, num screenHeight) {
    return CardMessage(
      headerTitle: "ASSUNTO",
      headerIcon: false,
      recentMessage: false,
      content: <Widget>[
        AutoSizeText(
          message.titulo,
          maxFontSize: 16,
          minFontSize: 14,
          maxLines: 2,
          style:
              TextStyle(color: Color(0xff666666), fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: screenHeight * 1.8,
        ),
        Container(
          width: screenHeight * 41,
          child: AutoSizeText(
            StringSupport.truncateEndString(message.mensagem, 250),
            maxFontSize: 16,
            minFontSize: 14,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color(0xff666666), height: screenHeight * 0.240),
          ),
        ),
        SizedBox(
          height: screenHeight * 3,
        ),
        AutoSizeText(
          DateFormatSuport.formatStringDate(message.criadoEm, 'dd/MM/yyyy'),
          maxFontSize: 16,
          minFontSize: 14,
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
                        builder: (context) => ViewMessage(
                            message: message, token: widget.token)));
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
                        color: Color(0xffC65D00), fontWeight: FontWeight.w700),
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
    );
  }

  Widget _buildListMessages(
      BuildContext context, num screenHeight, String token) {
    return Observer(builder: (context) {
      var messages = _messagesController.messages;
      if (messages != null) {
        var recentMessage = messages.last;
        return Visibility(
          visible: !_messagesController.isLoading,
          child: Column(
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
                recentMessage: true,
                content: <Widget>[
                  AutoSizeText(
                    recentMessage.titulo,
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
                      recentMessage.mensagem,
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
                  AutoSizeText(
                    DateFormatSuport.formatStringDate(
                        recentMessage.criadoEm, 'dd/MM/yyyy'),
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
                footer: true,
                footerContent: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewMessage(
                                  message: recentMessage, token: token)));
                    },
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
                                  builder: (context) => ViewMessage(
                                        token: token,
                                        message: recentMessage,
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
                height: screenHeight * 5,
              ),
              AutoSizeText(
                messages.length > 1
                    ? "${messages.length - 1} MENSAGENS ANTIGAS"
                    : "${messages.length} MENSSAGEM ANTIGA",
                maxFontSize: 18,
                minFontSize: 16,
                style: TextStyle(
                    color: Color(0xffDE9524), fontWeight: FontWeight.w500),
              ),
              Container(
                height: screenHeight * 60,
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _cardItems(context, messages[index], screenHeight);
                    }),
              )
            ],
          ),
          replacement: GFLoader(
            type: GFLoaderType.square,
            loaderColorOne: Color(0xffDE9524),
            loaderColorTwo: Color(0xffC65D00),
            loaderColorThree: Color(0xffC65D00),
            size: GFSize.LARGE,
          ),
        );
      } else {
        return Container();
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
      body: SingleChildScrollView(
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
    );
  }
}
