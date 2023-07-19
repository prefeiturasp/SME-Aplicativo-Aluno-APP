import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EADefaultButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final IconData? icon;
  final Color iconColor;
  final VoidCallback onPress;
  final bool enabled;

  EADefaultButton(
      {required this.text,
      required this.btnColor,
      required this.onPress,
      this.icon,
      required this.iconColor,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: screenHeight * 6,
      decoration: BoxDecoration(
          color: !enabled ? Color(0xffF2F1EE) : btnColor, borderRadius: BorderRadius.circular(screenHeight * 3)),
      child: ElevatedButton(
        onPressed: !enabled ? null : onPress,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              text,
              maxFontSize: 16,
              minFontSize: 14,
              style: TextStyle(color: !enabled ? Color(0xffC4C4C4) : Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: screenHeight * 3,
            ),
            Visibility(
              visible: icon != null,
              child: Icon(
                icon,
                color: !enabled ? Color(0xffC4C4C4) : iconColor,
                size: screenHeight * 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
