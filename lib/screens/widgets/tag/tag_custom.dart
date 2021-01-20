import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TagCustom extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  TagCustom({@required this.text, @required this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      padding: EdgeInsets.only(
          left: screenHeight * 2.2,
          top: screenHeight * 0.9,
          right: screenHeight * 2.2,
          bottom: screenHeight * 0.9),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
      ),
      child: AutoSizeText(
        text.toUpperCase(),
        maxFontSize: 12,
        minFontSize: 10,
        style: TextStyle(
            color: textColor != null ? textColor : Colors.white,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
