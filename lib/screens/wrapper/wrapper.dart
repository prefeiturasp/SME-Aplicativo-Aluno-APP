import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/auth/authenticate.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/messages/view_message_notification.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  AuthenticateController _authenticateController;

  @override
  initState() {
    super.initState();
    _initPushNotificationHandlers();
    _authenticateController = AuthenticateController();
    _authenticateController.loadCurrentUser();
  }

  _initPushNotificationHandlers() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then(print);
    _firebaseMessaging.subscribeToTopic("AppAluno");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage ---> Push Notification: $message");
        _popUpNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch ---> Push Notification: $message");
        await _navigateToMessageView(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume ---> Push Notification: $message");
        await _navigateToMessageView(message);
      },
    );
  }

  _popUpNotification(Map<String, dynamic> message) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: true,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: "NOTIFICAÇÃO - ${message["data"]["categoriaNotificacao"]}",
        desc: "Você acaba de receber uma \n mensagem.",
        btnOkOnPress: () {
          _navigateToMessageView(message);
        },
        btnOkText: "VISUALIZAR")
      ..show();
  }

  _navigateToMessageView(Map<String, dynamic> message) async {
    Message _message = Message(
      id: int.parse(message["data"]["Id"]),
      titulo: message["data"]["Titulo"],
      mensagem: message["data"]["Mensagem"],
      criadoEm: message["data"]["CriadoEm"],
      codigoEOL: message["data"]["CodigoEOL"] != null
          ? int.parse(message["data"]["CodigoEOL"])
          : 0,
      categoriaNotificacao: message["data"]["categoriaNotificacao"],
    );
    Nav.push(
        context,
        ViewMessageNotification(
          message: _message,
          userId: _authenticateController.user.id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      // BackgroundFetch.stop().then((int status) {
      //   print('[BackgroundFetch] stop success: $status');
      // });
      return NotInteernet();
    } else {
      return Observer(builder: (context) {
        if (_authenticateController.user == null) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: _authenticateController.isLoading
                  ? GFLoader(
                      type: GFLoaderType.square,
                      loaderColorOne: Color(0xffDE9524),
                      loaderColorTwo: Color(0xffC65D00),
                      loaderColorThree: Color(0xffC65D00),
                      size: GFSize.LARGE,
                    )
                  : Login());
        } else {
          if (_authenticateController.user.primeiroAcesso) {
            return FirstAccess(
              id: _authenticateController.user.id,
              cpf: _authenticateController.user.cpf,
            );
          } else if (_authenticateController.user.informarCelularEmail) {
            return ChangeEmailOrPhone(
              cpf: _authenticateController.user.cpf,
              userId: _authenticateController.user.id,
              password: "_password",
            );
          } else {
            return ListStudants(
                userId: _authenticateController.user.id, password: "");
          }
        }
      });
    }
  }
}
