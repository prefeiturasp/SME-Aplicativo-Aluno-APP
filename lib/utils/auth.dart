import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/screens/login/login.dart';

class Auth {
  static logout(BuildContext context) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var ids = new List<int>.generate(20, (i) => i + 1);
    ids.forEach((element) {
      print("logout remove Ids: $element");
      _firebaseMessaging.unsubscribeFromTopic(element.toString());
    });

    prefs.remove('current_name');
    prefs.remove('current_cpf');
    prefs.remove('current_email');
    prefs.remove('token');
    prefs.remove('password');
    prefs.remove('dispositivo_id');
    prefs.remove('current_user_id');
    // prefs.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
