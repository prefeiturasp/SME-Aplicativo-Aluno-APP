import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/autenticacao.controller.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/ui/views/login.view.dart';
import 'package:sme_app_aluno/screens/messages/view_message_notification.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/ui/views/atualizacao_cadastral.view.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  MessagesController _messagesController;

  @override
  initState() {
    super.initState();
    _initPushNotificationHandlers();
    _messagesController = MessagesController();
    usuarioStore.carregarUsuario();
  }

  @override
  void dispose() {
    usuarioStore.limparUsuario();
    super.dispose();
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

    await _messagesController.loadById(_message.id, usuarioStore.usuario.id);
    _message.mensagem = _messagesController.message.mensagem;
    Nav.push(
        context,
        ViewMessageNotification(
          message: _message,
          userId: usuarioStore.usuario.id,
        ));
  }

  Widget fluxoLogin() {
    if (usuarioStore.usuario != null) {
      if (usuarioStore.usuario.primeiroAcesso) {
        return FirstAccess(
          id: usuarioStore.usuario.id,
          cpf: usuarioStore.usuario.cpf,
        );
      } else if (usuarioStore.usuario.atualizarDadosCadastrais) {
        return AtualizacaoCadastralView();
      } else {
        return ListStudants(
          userId: usuarioStore.usuario.id,
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: new Center(
        child: GFLoader(
          type: GFLoaderType.square,
          loaderColorOne: Color(0xffDE9524),
          loaderColorTwo: Color(0xffC65D00),
          loaderColorThree: Color(0xffC65D00),
          size: GFSize.LARGE,
        ),
      ),
    );
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
      return Observer(
          builder: (context) => usuarioStore.usuario == null
              ? LoginView()
              : (usuarioStore.usuario.primeiroAcesso == null
                  ? LoginView()
                  : fluxoLogin()));
    }
  }
}

// Observer(
//         builder: (context) {
//           if (usuarioStore.usuario == null) {
//             return LoginView();
//           } else {
//             if (usuarioStore.usuario != null) {
//               if (usuarioStore.usuario.primeiroAcesso) {
//                 return FirstAccess(
//                   id: usuarioStore.usuario.id,
//                   cpf: usuarioStore.usuario.cpf,
//                 );
//               } else if (usuarioStore.usuario.atualizarDadosCadastrais) {
//                 return AtualizacaoCadastralView();
//               } else {
//                 return ListStudants(
//                   userId: usuarioStore.usuario.id,
//                 );
//               }
//             }
//           }
//         },
//       );
