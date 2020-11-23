import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BoxFrequency extends StatelessWidget {
  final String title;
  final String idbox;
  final bool fail;

  BoxFrequency({
    @required this.title,
    @required this.idbox,
    this.fail = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Column(
      children: [
        AutoSizeText(
          title,
          maxFontSize: 14,
          minFontSize: 12,
          style: TextStyle(
            color: Color(0xff4D4D4D),
          ),
        ),
        SizedBox(
          height: screenHeight * 1,
        ),
        Container(
          width: screenHeight * 8,
          height: screenHeight * 4,
          decoration: BoxDecoration(
            color: fail ? Colors.white : Color(0xffEDEDED),
            borderRadius: BorderRadius.all(
              Radius.circular(screenHeight * 0.8),
            ),
            border: fail
                ? Border.all(
                    color: Color(0xffC65D00), width: screenHeight * 0.2)
                : null,
          ),
          child: Center(
            child: AutoSizeText(
              idbox,
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                color: fail ? Color(0xffC65D00) : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
