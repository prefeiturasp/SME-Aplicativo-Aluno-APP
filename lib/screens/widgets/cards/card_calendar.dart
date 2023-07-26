import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../ui/widgets/buttons/ea_deafult_button.widget.dart';

class CardCalendar extends StatelessWidget {
  final String title;
  final String? month;
  final bool isHeader;
  final VoidCallback? onPress;
  final Widget? widget;
  final String totalEventos;
  final double heightContainer;

  const CardCalendar({
    super.key,
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
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: Colors.white,
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
            padding: isHeader ? EdgeInsets.all(screenHeight * 2.5) : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: isHeader ? const Color(0xffFFD037) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 2),
                topRight: Radius.circular(screenHeight * 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isHeader
                    ? Container(
                        margin: EdgeInsets.only(right: screenHeight * 2),
                        child: Icon(
                          FontAwesomeIcons.calendarAlt,
                          color: const Color(0xffC45C04),
                          size: screenHeight * 2.7,
                        ),
                      )
                    : Container(),
                isHeader
                    ? AutoSizeText(
                        title,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: const TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(screenHeight * 5)),
                    color: const Color(0xFFF3F3F3),
                  ),
                  child: AutoSizeText(
                    month.toString().toUpperCase(),
                    maxFontSize: 18,
                    minFontSize: 16,
                    style: const TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 2,
                ),
                Container(color: Colors.white, height: heightContainer, child: widget),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        totalEventos,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xffCDCDCD)),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
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
                  child: Container(
                    height: screenHeight * 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffC65D00), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 3),
                      ),
                    ),
                    child: EADefaultButton(
                      btnColor: Colors.white,
                      iconColor: const Color(0xffffd037),
                      icon: FontAwesomeIcons.chevronRight,
                      text: 'VER AGENDA COMPLETA',
                      styleAutoSize: const TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                      onPress: onPress ?? () {},
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
