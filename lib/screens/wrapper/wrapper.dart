import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Storage storage = Storage();
  AuthenticateController _authenticateController;

  String _cpf;
  String _token;
  String _password;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
    _authenticateController = AuthenticateController();
    _initPushNotificationHandlers();
  }

  void _initPushNotificationHandlers() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then(print);
    _firebaseMessaging.configure(
        onMessage: _onMessage,
        onBackgroundMessage: _onMessage,
        onLaunch: _onMessage,
        onResume: _onMessage);
  }

  static Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    print(message);
  }

  loadCurrentUser() async {
    setState(() {
      _loading = true;
    });
    bool isCurrentUser = await storage.containsKey("current_cpf");
    if (isCurrentUser) {
      String cpf = await storage.readValueStorage('current_cpf');
      String token = await storage.readValueStorage('token');
      String password = await storage.readValueStorage('current_password');
      setState(() {
        _cpf = cpf;
        _token = token;
        _password = password;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = _cpf != null && _token != null;

    bool notErrorAuthenticate = _authenticateController.currentUser != null &&
        _authenticateController.currentUser.erros[0].isNotEmpty;

    if (!isAuthenticated || notErrorAuthenticate) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: _loading
              ? GFLoader(
                  type: GFLoaderType.square,
                  loaderColorOne: Color(0xffDE9524),
                  loaderColorTwo: Color(0xffC65D00),
                  loaderColorThree: Color(0xffC65D00),
                  size: GFSize.LARGE,
                )
              : Login());
    } else {
      return ListStudants(cpf: _cpf, token: _token, password: _password);
    }
  }
}
