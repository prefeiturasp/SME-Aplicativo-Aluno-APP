import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LabelFrequency extends StatelessWidget {
  final String text;

  LabelFrequency({required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxFontSize: 16,
      minFontSize: 14,
      style: TextStyle(
        color: Color(0xff4D4D4D),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
