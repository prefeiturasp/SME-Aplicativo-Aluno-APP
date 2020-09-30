import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Event extends StatelessWidget {
  final String tipoEvento;
  final String nome;
  final bool desc;
  final String dia;
  final String diaSemana;
  final String eventDesc;

  Event({
    this.tipoEvento,
    this.nome,
    this.desc,
    this.dia,
    this.diaSemana,
    this.eventDesc,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorAvaliacao = Color(0xFF9C33AD);
    const colorReuniao = Color(0xFFE1771D);
    const colorOutros = Color(0xFFC4C4C4);

    viewEvent() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(nome),
            content: new Text(eventDesc),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Voltar"),
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
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenHeight * 30,
                  child: Wrap(
                    children: [
                      AutoSizeText(
                        diaSemana + " - " + nome,
                        maxFontSize: 16,
                        minFontSize: 14,
                      )
                    ],
                  ),
                ),
                desc == true
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.stickyNote),
                        onPressed: () {
                          viewEvent();
                        })
                    : SizedBox.shrink()
              ],
            ),
            leading: CircleAvatar(
                backgroundColor: tipoEvento == "avaliacao"
                    ? colorAvaliacao
                    : tipoEvento == "reuniao"
                        ? colorReuniao
                        : colorOutros,
                child: Text(
                  dia,
                  style: TextStyle(
                      fontSize: screenHeight * 2, color: Colors.white),
                )),
          ),
        ));
  }
}
