import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Observation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      padding: EdgeInsets.all(screenHeight * 2),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeText("Recomendações a familia",
              minFontSize: 16, maxFontSize: 18),
          Divider(
            height: screenHeight * 5,
            thickness: 2,
          ),
          Wrap(
            children: [
              AutoSizeText(
                  "Neste campo será inserido um texto de recomendação a familia referente as notas do estudante.",
                  minFontSize: 18,
                  maxFontSize: 20),
            ],
          )
        ],
      ),
    );
  }
}
