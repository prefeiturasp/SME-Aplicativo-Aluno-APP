import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Auth {
  static logout(BuildContext context, int id) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    final UserService _userService = UserService();

    // var ids = new List<int>.generate(20, (i) => i + 1);
    // ids.forEach((element) {
    //   print("logout remove Ids: $element");
    //   _firebaseMessaging.unsubscribeFromTopic(element.toString());
    // });

    await _userService.delete(id);
    // prefs.clear();
    Nav.push(context, Login());
  }
}
