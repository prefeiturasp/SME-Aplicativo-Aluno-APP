import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EADefaultButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final IconData? icon;
  final Color iconColor;
  final VoidCallback onPress;
  final bool enabled;
  final bool iconeVoltar;
  final TextStyle? styleAutoSize;

  const EADefaultButton({
    super.key,
    required this.text,
    required this.btnColor,
    required this.onPress,
    this.icon,
    this.styleAutoSize,
    required this.iconColor,
    this.enabled = true,
    this.iconeVoltar = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: screenHeight * 5.23,
      decoration: BoxDecoration(
        color: !enabled ? const Color(0xffF2F1EE) : btnColor,
        borderRadius: BorderRadius.circular(screenHeight * 3),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenHeight * 3),
          ),
        ),
        onPressed: !enabled ? null : onPress,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: iconeVoltar ? iconesVoltartela(screenHeight) : iconesProximatela(screenHeight),
        ),
      ),
    );
  }

  List<Widget> iconesProximatela(double screenHeight) {
    return <Widget>[
      AutoSizeText(
        text,
        minFontSize: 10,
        style: styleAutoSize ??
            TextStyle(color: !enabled ? const Color(0xffC4C4C4) : Colors.white, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: screenHeight * 3,
      ),
      Visibility(
        visible: icon != null,
        child: Icon(
          icon,
          color: !enabled ? const Color(0xffC4C4C4) : iconColor,
          size: screenHeight * 3,
        ),
      ),
    ];
  }

  List<Widget> iconesVoltartela(double screenHeight) {
    return <Widget>[
      Visibility(
        visible: icon != null,
        child: Icon(
          icon,
          color: !enabled ? const Color(0xffC4C4C4) : iconColor,
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
        style: styleAutoSize ??
            TextStyle(color: !enabled ? const Color(0xffC4C4C4) : Colors.white, fontWeight: FontWeight.w700),
      ),
    ];
  }
}
