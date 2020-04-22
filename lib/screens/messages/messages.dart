import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';


// TODO Remover injecao de token e colocar em um provider de acesso
class MessagesWidget extends StatefulWidget {
  final String oauthToken;

  MessagesWidget({ Key key, String oauthToken, List<Message> messages })
    : this.oauthToken = oauthToken,
      super(key: key);

  _MessagesState createState() => _MessagesState();
}


class _MessagesState extends State<MessagesWidget> {
  String _oauthToken;

  MessagesController _controller;

  List<Message> _messages;

  _MessagesState({ String oauthToken }) {
    this._controller = MessagesController();
    this._oauthToken = oauthToken;
    this._messages = [];

    if(oauthToken == null)
      this._initStateAsync();
  }

  _initStateAsync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._oauthToken = prefs.getString("token");
    await this._loadUserMessages();
  }

  _loadUserMessages() async {
    this._messages = await this._controller.loadMessages(this._oauthToken);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    Iterable messageCardList = this._messages
      ?.map((m) => _buildCardMessage(m, screenHeight))
      ?.toList() ?? [];

    var children = [
      SizedBox(
        height: screenHeight * 2.5,
      ),
      AutoSizeText(
        "MENSAGEM MAIS RECENTE",
        style: TextStyle(
            color: Color(0xffDE9524), fontWeight: FontWeight.w500),
      )
    ];

    messageCardList.forEach((card) {
      children.add(card);
      children.add(SizedBox(
        height: screenHeight * 6,
      ));
    });

    children.addAll([
      AutoSizeText(
        "0 MENSAGEN(S) ANTIGA(S)",
        style: TextStyle(
            color: Color(0xffDE9524), fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: screenHeight * 3,
      ),
    ]);

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
            children: children,
          ),
        ),
      ),
    );
  }

  _buildCardMessage(Message message, double screenHeight) {
    return CardMessage(
      headerTitle: "ASSUNTO",
      headerIcon: true,
      recentMessage: true,
      content: <Widget>[
        AutoSizeText(
          message.titulo,
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
            message.mensagem,
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
    );
  }
}
