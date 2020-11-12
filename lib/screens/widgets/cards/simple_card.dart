import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      height: screenHeight * 14,
      padding: EdgeInsets.all(screenHeight * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          AutoSizeText(
            "Frequência global do estudante",
            textAlign: TextAlign.left,
            maxFontSize: 22,
            minFontSize: 18,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
