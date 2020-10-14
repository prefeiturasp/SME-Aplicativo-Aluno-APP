import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/screens/calendar/event.dart';

class CardCalendar extends StatelessWidget {
  final String title;
  final String month;
  final String text;
  final double textSize;
  final bool isHeader;
  final Function onPress;
  final Widget widget;
  final String totalEventos;

  CardCalendar({
    this.title,
    this.month,
    this.text,
    this.isHeader = true,
    this.textSize,
    this.onPress,
    this.widget,
    this.totalEventos,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: [
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
            padding:
                isHeader ? EdgeInsets.all(screenHeight * 2.5) : EdgeInsets.zero,
            decoration: BoxDecoration(
                color: isHeader ? Color(0xffFFD037) : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isHeader
                    ? Container(
                        margin: EdgeInsets.only(right: screenHeight * 2),
                        child: Icon(
                          FontAwesomeIcons.calendarAlt,
                          color: Color(0xffC45C04),
                          size: screenHeight * 2.7,
                        ),
                      )
                    : Container(),
                isHeader
                    ? AutoSizeText(
                        title,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                            color: Color(0xffC45C04),
                            fontWeight: FontWeight.w700),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 3),
            padding: EdgeInsets.all(screenHeight * 1.5),
            width: screenHeight * 40,
            child: AutoSizeText(
              month,
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                  color: Color(0xffC45C04), fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              color: Color(0xFFF3F3F3),
            ),
          ),
          Container(
              padding: EdgeInsets.all(screenHeight * 1.5),
              color: Colors.white,
              child: widget),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight * 2),
                  bottomRight: Radius.circular(screenHeight * 2)),
            ),
            padding: EdgeInsets.only(
                left: screenHeight * 2.5,
                right: screenHeight * 2.5,
                top: screenHeight * 1.5,
                bottom: screenHeight * 1.5),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    totalEventos,
                    maxFontSize: 18,
                    minFontSize: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight * 2),
                  bottomRight: Radius.circular(screenHeight * 2)),
            ),
            padding: EdgeInsets.only(
                left: screenHeight * 2.5,
                right: screenHeight * 2.5,
                top: screenHeight * 1.5,
                bottom: screenHeight * 1.5),
            child: Container(
              child: Container(
                height: screenHeight * 6,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffC65D00), width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenHeight * 3),
                  ),
                ),
                child: FlatButton(
                  onPressed: onPress,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        "VER AGENDA COMPLETA",
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
                        FontAwesomeIcons.angleRight,
                        color: Color(0xffffd037),
                        size: screenHeight * 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
