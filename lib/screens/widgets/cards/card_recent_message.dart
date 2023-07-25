// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/message/message.dart';
import '../../../utils/date_format.dart';
import '../../../utils/string_support.dart';

class CardRecentMessage extends StatefulWidget {
  final Message? message;
  final int countMessages;
  final bool deleteBtn;
  final bool recent;
  final Function onPress;
  final VoidCallback outherRoutes;
  const CardRecentMessage({
    Key? key,
    this.message,
    required this.countMessages,
    this.deleteBtn = false,
    required this.recent,
    required this.onPress,
    required this.outherRoutes,
  }) : super(key: key);

  @override
  CardRecentMessageState createState() => CardRecentMessageState();
}

class CardRecentMessageState extends State<CardRecentMessage> {
  bool retorno = false;
  Future<bool> _confirmDeleteMessage(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você tem certeza que deseja excluir esta mensagem?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                retorno = true;
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                retorno = false;
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
    return retorno;
  }

  //_removeMesageToStorage(int id) async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: widget.message == null ? const Color(0xffC45C04) : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: const [
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
              color: widget.recent ? const Color(0xffE1771D) : const Color(0xffF8E8C2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 2),
                topRight: Radius.circular(screenHeight * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: screenHeight * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        widget.recent ? FontAwesomeIcons.envelope : FontAwesomeIcons.envelopeOpen,
                        color: widget.recent ? const Color(0xffFFD037) : const Color(0xffE1771D),
                        size: screenHeight * 2.7,
                      ),
                      SizedBox(
                        width: screenHeight * 1.5,
                      ),
                      AutoSizeText(
                        'MENSAGEM MAIS RECENTE',
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                          color: widget.recent ? Colors.white : const Color(0xffE1771D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.countMessages > 0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: screenHeight * 3.5,
                        height: screenHeight * 3.5,
                        decoration: BoxDecoration(
                          color: const Color(0xfffac635),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 1.750),
                          ),
                        ),
                        child: const Icon(
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
                              '${widget.countMessages}',
                              maxFontSize: 12,
                              minFontSize: 10,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xffC45C04)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onPress();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              color: widget.recent ? const Color(0xffC45C04) : Colors.white,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 1.8),
                child: widget.message != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            widget.message?.titulo ?? '',
                            maxFontSize: 16,
                            minFontSize: 14,
                            maxLines: 2,
                            style: TextStyle(
                              color: widget.recent ? Colors.white : const Color(0xff666666),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 1.8,
                          ),
                          SizedBox(
                            width: screenHeight * 36,
                            child: AutoSizeText(
                              StringSupport.parseHtmlString(
                                StringSupport.truncateEndString(widget.message?.mensagem ?? '', 250),
                              ),
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: widget.recent ? Colors.white : const Color(0xff666666),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 3,
                          ),
                          AutoSizeText(
                            DateFormatSuport.formatStringDate(
                              widget.message?.criadoEm ?? DateTime.now().toIso8601String(),
                              'dd/MM/yyyy',
                            ),
                            maxFontSize: 16,
                            minFontSize: 14,
                            maxLines: 2,
                            style: TextStyle(
                              color: widget.recent ? Colors.white : const Color(0xff666666),
                              fontWeight: FontWeight.w700,
                              height: screenHeight * 0.5,
                            ),
                          ),
                        ],
                      )
                    : const AutoSizeText(
                        'Nenhuma mensagem está disponível para este aluno',
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.countMessages > 0
                  ? widget.recent
                      ? null
                      : const Color(0xffF3F3F3)
                  : const Color(0xffC45C04),
              borderRadius: widget.countMessages > 0
                  ? widget.recent
                      ? null
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(screenHeight * 2),
                          bottomRight: Radius.circular(screenHeight * 2),
                        )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(screenHeight * 2),
                      bottomRight: Radius.circular(screenHeight * 2),
                    ),
            ),
            padding: EdgeInsets.only(
              left: screenHeight * 2.5,
              right: screenHeight * 2.5,
              top: screenHeight * 1.5,
              bottom: screenHeight * 1.5,
            ),
            child: widget.countMessages > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: widget.deleteBtn,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.message?.id != null) {
                              _confirmDeleteMessage(widget.message!.id);
                            }
                          },
                          child: Container(
                            width: screenHeight * 6,
                            height: screenHeight * 6,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffC65D00), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight * 3),
                              ),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.xmark,
                              color: Color(0xffC65D00),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffC65D00), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 3),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: widget.outherRoutes,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const AutoSizeText(
                                'VER TODAS',
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: screenHeight * 2,
                              ),
                              Icon(
                                FontAwesomeIcons.envelopeOpen,
                                color: const Color(0xffffd037),
                                size: screenHeight * 3,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
