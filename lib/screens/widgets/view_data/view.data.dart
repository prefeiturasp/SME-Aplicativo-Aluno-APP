import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ViewData extends StatelessWidget {
  final String label;
  final String text;
  final Color? backgroundColor;

  const ViewData({super.key, required this.label, required this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: screenHeight * 2.5),
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xffF0F0F0),
              borderRadius: BorderRadius.all(
                Radius.circular(screenHeight * 0.8),
              ),
            ),
            padding: EdgeInsets.only(
                left: screenHeight * 3, top: screenHeight * 1.5, right: screenHeight * 3, bottom: screenHeight * 1.5,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  label,
                  maxFontSize: 14,
                  minFontSize: 12,
                  style: const TextStyle(color: Color(0xff757575)),
                ),
                SizedBox(
                  height: screenHeight * 1,
                ),
                AutoSizeText(
                  text,
                  maxFontSize: 20,
                  minFontSize: 18,
                  style: const TextStyle(color: Color(0xff757575)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
