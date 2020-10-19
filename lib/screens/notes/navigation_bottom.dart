import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      height: screenHeight * 7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(
              5.0,
              5.0,
            ),
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenHeight * 1, right: screenHeight * 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.black.withOpacity(0.20),
                  ),
                  SizedBox(
                    width: screenHeight * 1,
                  ),
                  AutoSizeText("PREV",
                      minFontSize: 18,
                      maxFontSize: 20,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.20),
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            onTap: () {},
          ),
          rowCirculosWidget(screenHeight * 1.5, screenHeight * 1),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenHeight * 1, right: screenHeight * 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText("NEXT",
                      minFontSize: 18,
                      maxFontSize: 20,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.50),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: screenHeight * 1,
                  ),
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ],
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  circuloWidget(double screenHeight, Color color) {
    return Container(
      height: screenHeight,
      width: screenHeight,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(45))),
    );
  }

  rowCirculosWidget(double screenHeight, double sizedBox) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circuloWidget(screenHeight, Color(0xFFF6871F)),
        SizedBox(
          width: sizedBox,
        ),
        circuloWidget(screenHeight, Color(0xFFEDEDED)),
        SizedBox(
          width: sizedBox,
        ),
        circuloWidget(screenHeight, Color(0xFFEDEDED)),
      ],
    );
  }
}
