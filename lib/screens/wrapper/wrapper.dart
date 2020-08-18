import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/messages/view_message_notification.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/navigator.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Storage storage = Storage();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserService _userService = UserService();

  String _cpf = '';
  String _password = '';
  int _id;
  bool _loading = false;
  bool _primeiroAcesso = false;
  bool _informarCelularEmail = false;

  @override
  initState() {
    super.initState();
    loadCurrentUser();
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
          userId: _id,
        ));
  }

  loadCurrentUser() async {
    final List<User> users = await _userService.all();
    final User user = await _userService.find(users[0].id);
    if (user.cpf != null && user.cpf.isNotEmpty) {
      setState(() {
        _cpf = user.cpf;
        _id = user.id;
        _primeiroAcesso = user.primeiroAcesso;
        _informarCelularEmail = user.informarCelularEmail;
      });
    }
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
      if (_cpf == null) {
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
          return ListStudants(userId: _id, password: _password);
        }
      }
    }
  }
}
