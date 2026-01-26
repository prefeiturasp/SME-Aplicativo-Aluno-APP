import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../constantes/colors.dart';

class EventItem extends StatelessWidget {
  final int tipoEvento;
  final Widget customTitle;
  final String titleEvent;
  final bool desc;
  final String dia;
  final String eventDesc;
  final String componenteCurricular;

  const EventItem({
    super.key,
    required this.tipoEvento,
    required this.customTitle,
    required this.titleEvent,
    required this.desc,
    required this.dia,
    required this.eventDesc,
    required this.componenteCurricular,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    final DateTime dataInicio = DateTime.parse(dia);
    final formatDate = DateFormat('dd/MM/yyyy');

    Future viewEvent() {
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
                          'Avaliação: ${formatDate.format(dataInicio)}',
                          overflow: TextOverflow.clip,
                          maxLines: 4,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  componenteCurricular.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: dividerColor,
                            ),
                            const Text(
                              'Componente Curricular',
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              componenteCurricular,
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Divider(
                              color: dividerColor,
                            ),
                          ],
                        )
                      : const Divider(
                          color: dividerColor,
                        ),
                  const Text(
                    'Nome da Avaliação',
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    titleEvent,
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Divider(
                    color: dividerColor,
                  ),
                  const Text(
                    'Conteúdo',
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  HtmlWidget(eventDesc),
                  const Divider(
                    color: dividerColor,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('FECHAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        if (tipoEvento == 0) {
          viewEvent();
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: screenHeight * 1.3, top: screenHeight * 0.8),
        child: SizedBox(
          height: screenHeight * 2.9,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: (size.width / 1.1),
                        child: customTitle,
                      ),
                    ],
                  ),
                ),
                tipoEvento == 0
                    ? Icon(
                        FontAwesomeIcons.solidNoteSticky,
                        color: solidNoteStickyColor,
                        size: screenHeight * 2.1,
                      )
                    : const SizedBox.shrink(),
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
                maxFontSize: 14,
                minFontSize: 12,
                style: TextStyle(fontSize: screenHeight * 2, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
