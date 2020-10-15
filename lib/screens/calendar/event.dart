import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Event extends StatelessWidget {
  final int tipoEvento;
  final String nome;
  final bool desc;
  final String dia;
  final String eventDesc;

  Event({
    this.tipoEvento,
    this.nome,
    this.desc,
    this.dia,
    this.eventDesc,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorAvaliacao = Color(0xFF9C33AD);
    const colorReuniao = Color(0xFFE1771D);
    const colorOutros = Color(0xFFC4C4C4);

    DateTime date = DateTime.parse(dia);

    viewEvent() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(nome),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Html(
                  data: eventDesc,
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
        padding: EdgeInsets.only(
            bottom: screenHeight * 1.5, top: screenHeight * 1.5),
        child: Container(
          height: screenHeight * 6,
          child: InkWell(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenHeight * 30,
                    child: Wrap(
                      children: [
                        AutoSizeText(
                          nome,
                          maxFontSize: 16,
                          minFontSize: 14,
                        )
                      ],
                    ),
                  ),
                  desc == true
                      ? Icon(FontAwesomeIcons.stickyNote,
                          color: Color(0xFFE1771D))
                      : SizedBox.shrink()
                ],
              ),
              leading: CircleAvatar(
                  backgroundColor: tipoEvento == 0
                      ? colorAvaliacao
                      : tipoEvento == 16
                          ? colorReuniao
                          : tipoEvento == 17
                              ? colorReuniao
                              : tipoEvento == 19
                                  ? colorReuniao
                                  : colorOutros,
                  child: Text(date.day.toString(),
                      style: TextStyle(
                          fontSize: screenHeight * 2, color: Colors.white))),
            ),
            onTap: () {
              desc == true ? viewEvent() : null;
            },
          ),
        ));
  }
}
