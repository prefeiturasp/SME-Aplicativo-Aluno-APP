import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../utils/string_support.dart';

class TitleEvent extends StatelessWidget {
  final String dayOfWeek;
  final String title;

  const TitleEvent({
    super.key,
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
            dayOfWeek,
            maxFontSize: 14,
            minFontSize: 12,
            maxLines: 1,
            style: TextStyle(
              color: dayOfWeek == 'Sab' || dayOfWeek == 'Dom' ? Colors.red : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: AutoSizeText(
            StringSupport.truncateEndString(title, 26),
            textAlign: TextAlign.left,
            maxFontSize: 14,
            minFontSize: 12,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
