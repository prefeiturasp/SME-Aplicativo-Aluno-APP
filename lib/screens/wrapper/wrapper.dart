import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/messages/view_message_notification.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Storage storage = Storage();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AuthenticateController _authenticateController;

  String _cpf;
  String _token;
  String _password;
  int _id;
  bool _loading = false;
  bool _primeiroAcesso = false;
  bool _informarCelularEmail = false;

  @override
  initState() {
    super.initState();
    loadCurrentUser();
    _authenticateController = AuthenticateController();
    _initPushNotificationHandlers();
  }

  _initPushNotificationHandlers() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then(print);
    _firebaseMessaging.subscribeToTopic("AppAluno");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _popUpNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        await _navigateToMessageView(message);
      },
      onResume: (Map<String, dynamic> message) async {
        await _navigateToMessageView(message);
      },
    );
  }

  _popUpNotification(Map<String, dynamic> message) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'NOTIFICAÇÃO',
        desc: "Você acaba de receber uma \n mensagem da SME",
        btnOkOnPress: () {
          _navigateToMessageView(message);
        },
        btnOkText: "VISUALIZAR")
      ..show();
  }

  // teste
  _navigateToMessageView(Map<String, dynamic> message) async {
    Message _message = Message(
      id: int.parse(message["data"]["Id"]),
      titulo: message["data"]["Titulo"],
      mensagem: message["data"]["Mensagem"],
      criadoEm: message["data"]["CriadoEm"],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ViewMessageNotification(
                  message: _message,
                )));
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
      int id = await storage.readValueIntStorage('current_user_id');
      bool primeiroAcesso =
          await storage.readValueBoolStorage('current_primeiro_acesso');
      bool informarCelularEmail =
          await storage.readValueBoolStorage('current_informar_celular_email');

      setState(() {
        _cpf = cpf;
        _token = token;
        _password = password;
        _primeiroAcesso = primeiroAcesso;
        _informarCelularEmail = informarCelularEmail;
        _id = id;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
      return NotInteernet();
    } else {
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
        if (_primeiroAcesso) {
          return FirstAccess(
            id: _id,
            isPhoneAndEmail: _informarCelularEmail,
            cpf: _cpf,
          );
        } else if (_informarCelularEmail) {
          return ChangeEmailOrPhone(
            cpf: _cpf,
            password: _password,
          );
        } else {
          return ListStudants(cpf: _cpf, token: _token, password: _password);
        }
      }
    }
  }
}
