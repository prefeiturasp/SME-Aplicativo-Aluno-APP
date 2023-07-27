import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LabelEvent extends StatelessWidget {
  final String labelName;
  final Color labelColor;

  const LabelEvent({
    super.key,
    required this.labelName,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.all(
              Radius.circular(screenHeight * 2),
            ),
          ),
          width: screenHeight * 2.5,
          height: screenHeight * 2.5,
          margin: EdgeInsets.only(
            bottom: screenHeight * 0.5,
            top: screenHeight * 0.5,
          ),
        ),
        SizedBox(
          width: screenHeight * 1,
        ),
        AutoSizeText(
          labelName,
          maxFontSize: 16,
          minFontSize: 14,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xff333333),
          ),
        ),
      ],
    );
  }
}
