import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardCalendar extends StatelessWidget {
  final String title;
  final String? month;
  final bool isHeader;
  final VoidCallback? onPress;
  final Widget? widget;
  final String totalEventos;
  final double heightContainer;

  CardCalendar({
    this.month,
    this.isHeader = true,
    this.onPress,
    this.widget,
    required this.title,
    required this.totalEventos,
    required this.heightContainer,
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
            padding: isHeader ? EdgeInsets.all(screenHeight * 2.5) : EdgeInsets.zero,
            decoration: BoxDecoration(
                color: isHeader ? Color(0xffFFD037) : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2), topRight: Radius.circular(screenHeight * 2))),
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
                        style: TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(screenHeight * 1.5),
            child: Column(
              children: [
                Container(
                  width: screenHeight * 35,
                  height: screenHeight * 5,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    month.toString().toUpperCase(),
                    maxFontSize: 18,
                    minFontSize: 16,
                    style: TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(screenHeight * 5)),
                    color: Color(0xFFF3F3F3),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 2,
                ),
                Container(color: Colors.white, height: heightContainer, child: widget),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(screenHeight * 2), bottomRight: Radius.circular(screenHeight * 2)),
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
                          style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xffCDCDCD)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(screenHeight * 2), bottomRight: Radius.circular(screenHeight * 2)),
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
                      child: ElevatedButton(
                        onPressed: onPress,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              "VER AGENDA COMPLETA",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
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
          )
        ],
      ),
    );
  }
}
