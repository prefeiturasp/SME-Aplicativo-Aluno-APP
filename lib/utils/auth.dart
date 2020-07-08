import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class Auth {
  static logout(BuildContext context) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    final Storage _storage = Storage();

    var ids = new List<int>.generate(20, (i) => i + 1);
    ids.forEach((element) {
      print("logout remove Ids: $element");
      _firebaseMessaging.unsubscribeFromTopic(element.toString());
    });

    removeCurrentUser();
    // prefs.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  static removeCurrentUser() {
    final Storage _storage = Storage();
    _storage.removeKey('current_user_id');
    _storage.removeKey('current_name');
    _storage.removeKey('current_cpf');
    _storage.removeKey('current_email');
    _storage.removeKey('token');
    _storage.removeKey('current_password');
    _storage.removeKey('dispositivo_id');
  }
}
