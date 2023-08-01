import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class Note extends StatelessWidget {
  final String name;
  final String noteValue;
  final String description;
  final bool current;
  final Color color;

  const Note({
    super.key,
    required this.name,
    required this.noteValue,
    required this.description,
    required this.current,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    Future viewEvent() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [HtmlWidget(description)],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('FECHAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          name,
          maxFontSize: 14,
          minFontSize: 12,
          style: TextStyle(color: current ? const Color(0xFFC65D00) : Colors.black),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: screenHeight * 1,
        ),
        InkWell(
          onTap: description.isNotEmpty && description.length > 5
              ? () {
                  viewEvent();
                }
              : null,
          child: Container(
            padding: EdgeInsets.all(screenHeight * 0.8),
            decoration: BoxDecoration(
              border:
                  Border.all(width: current ? screenHeight * 0.3 : 0.0, color: current ? color : Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(screenHeight * 1)),
              color: noteValue == '-'
                  ? const Color(0xFFEDEDED).withOpacity(0.4)
                  : current
                      ? color.withOpacity(0.4)
                      : const Color(0xFFEDEDED),
            ),
            width: screenHeight * 8,
            child: AutoSizeText(
              noteValue,
              maxFontSize: 14,
              minFontSize: 12,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
