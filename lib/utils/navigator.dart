import 'package:flutter/material.dart';

class Nav {
  static void push(
    BuildContext context,
    Widget screen, {
    bool fullscreenDialog = false,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void pop(BuildContext context, {int screens = 0}) {
    if (screens == 0) {
      Navigator.pop(context);
    } else {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= screens);
    }
  }
}
