import 'package:flutter/material.dart';

class EAIconButton extends StatelessWidget {
  final VoidCallback onPress;
  final double screenHeight;
  final Icon iconBtn;

  EAIconButton({
    required this.onPress,
    required this.screenHeight,
    required this.iconBtn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: screenHeight * 6,
        height: screenHeight * 6,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffC65D00), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(screenHeight * 3),
          ),
        ),
        child: iconBtn,
      ),
    );
  }
}
