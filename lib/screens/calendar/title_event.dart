import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class TitleEvent extends StatelessWidget {
  final String dayOfWeek;
  final String title;

  TitleEvent({
    required this.dayOfWeek,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AutoSizeText(
            "$dayOfWeek",
            maxFontSize: 14,
            minFontSize: 12,
            maxLines: 1,
            style: TextStyle(
                color: dayOfWeek == "Sab" || dayOfWeek == "Dom" ? Colors.red : Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 8,
          child: AutoSizeText(
            StringSupport.truncateEndString(title, 40),
            textAlign: TextAlign.left,
            maxFontSize: 14,
            minFontSize: 12,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
