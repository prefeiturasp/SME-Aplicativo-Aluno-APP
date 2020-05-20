import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/screens/login/login.dart';

class Auth {
  static logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
