import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final int tipoEvento;
  final Widget customTitle;
  final String titleEvent;
  final bool desc;
  final String dia;
  final String eventDesc;
  final String componenteCurricular;

  EventItem({
    this.tipoEvento,
    this.customTitle,
    this.titleEvent,
    this.desc,
    this.dia,
    this.eventDesc,
    this.componenteCurricular,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorAvaliacao = Color(0xFF9C33AD);
    const colorReuniao = Color(0xFFE1771D);
    const colorOutros = Color(0xFFC4C4C4);

    DateTime dataInicio = DateTime.parse(dia);
    final formatDate = DateFormat('dd/MM/yyyy');

    viewEvent() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Icon(
                          FontAwesomeIcons.calendarDay,
                          color: tipoEvento == 0
                              ? colorAvaliacao
                              : tipoEvento == 16
                                  ? colorReuniao
                                  : tipoEvento == 17
                                      ? colorReuniao
                                      : tipoEvento == 19
                                          ? colorReuniao
                                          : colorOutros,
                          size: screenHeight * 2,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          "Avaliação: ${formatDate.format(dataInicio)}",
                          overflow: TextOverflow.clip,
                          maxLines: 4,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  componenteCurricular != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Color(0xffCDCDCD),
                            ),
                            Text(
                              "Componente Curricular",
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              componenteCurricular,
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Divider(
                              color: Color(0xffCDCDCD),
                            ),
                          ],
                        )
                      : Divider(
                          color: Color(0xffCDCDCD),
                        ),
                  Text(
                    "Nome da Avaliação",
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    titleEvent,
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(color: Colors.black),
                  ),
                  Divider(
                    color: Color(0xffCDCDCD),
                  ),
                  Text(
                    "Conteúdo",
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Html(
                    data: eventDesc,
                  ),
                  Divider(
                    color: Color(0xffCDCDCD),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("FECHAR"),
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
        padding:
            EdgeInsets.only(bottom: screenHeight * 1.5, top: screenHeight * 1),
        child: Container(
          height: screenHeight * 6,
          child: InkWell(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Container(
                        width: (size.width / 1.75),
                        child: customTitle,
                      )
                    ],
                  ),
                  tipoEvento == 0
                      ? Icon(
                          FontAwesomeIcons.solidStickyNote,
                          color: Color(0xFF086397),
                          size: screenHeight * 2.2,
                        )
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
                  child: AutoSizeText(
                    dataInicio.day.toString(),
                    maxFontSize: 16,
                    minFontSize: 14,
                    style: TextStyle(
                        fontSize: screenHeight * 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            onTap: () {
              if (tipoEvento == 0) {
                viewEvent();
              }
            },
          ),
        ));
  }
}
