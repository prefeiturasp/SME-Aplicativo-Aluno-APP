import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TileItem extends StatelessWidget {
  final String header;
  final List<Widget> body;

  TileItem({
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: false,
        title: AutoSizeText(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          minFontSize: 14,
          maxFontSize: 16,
          textAlign: TextAlign.start,
        ),
        children: body,
      ),
    );
  }
}
