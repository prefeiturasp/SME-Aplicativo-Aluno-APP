import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EABackButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final IconData icon;
  final Color iconColor;
  final Function onPress;
  final bool disabled;

  EABackButton(
      {required this.text,
      required this.btnColor,
      required this.onPress,
      this.icon,
      this.iconColor,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: screenHeight * 6,
        decoration: BoxDecoration(
            color: !disabled ? Color(0xffF2F1EE) : btnColor, borderRadius: BorderRadius.circular(screenHeight * 3)),
        child: ElevatedButton(
            onPressed: !disabled ? null : onPress,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: icon != null,
                  child: Icon(
                    icon,
                    color: !disabled ? Color(0xffC4C4C4) : iconColor,
                    size: screenHeight * 3,
                  ),
                ),
                SizedBox(
                  width: screenHeight * 3,
                ),
                AutoSizeText(
                  text,
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(color: !disabled ? Color(0xffC4C4C4) : Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            )));
  }
}
