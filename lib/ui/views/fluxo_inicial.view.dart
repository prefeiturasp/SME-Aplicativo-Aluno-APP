import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/autenticacao.controller.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/screens/messages/view_message_notification.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class FluxoInicialView extends StatefulWidget {
  @override
  _FluxoInicialViewState createState() => _FluxoInicialViewState();
}

class _FluxoInicialViewState extends State<FluxoInicialView> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final Stream<RemoteMessage> _firebaseonMessage = FirebaseMessaging.onMessage;
  final Stream<RemoteMessage> _firebaseonOnMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;

  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  late final MessagesController _messagesController;

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
    try {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getToken().then(print);
      _firebaseMessaging.subscribeToTopic("AppAluno");
      _firebaseMessaging.getInitialMessage().then((message) async {
        if (message != null) {
          await _navigateToMessageView(message.data);
        }
      });
      _firebaseonMessage.listen((RemoteMessage message) {
        _popUpNotification(message.data);
      });
      _firebaseonOnMessageOpenedApp.listen((event) async {
        await _navigateToMessageView(event.data);
      });
    } catch (ex) {
      log(ex.toString());
      throw Exception(ex);
    }
  }

  _popUpNotification(Map<String, dynamic> message) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: true,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
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
      codigoEOL: message["data"]["CodigoEOL"] != null ? int.parse(message["data"]["CodigoEOL"]) : 0,
      categoriaNotificacao: message["data"]["categoriaNotificacao"],
      dataEnvio: message["data"]["DataEnvio"],
      alteradoEm: message["data"]["AlteradoEm"],
      mensagemVisualizada: message["data"]["MensagemVisualizada"],
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
    if (usuarioStore.usuario.primeiroAcesso) {
      return FirstAccess(
        id: usuarioStore.usuario.id,
        cpf: usuarioStore.usuario.cpf,
      );
    } else if (usuarioStore.usuario.atualizarDadosCadastrais) {
      return AtualizacaoCadastralView();
    } else {
      return EstudanteListaView();
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
      return NotInteernet();
    } else {
      return Observer(
        builder: (context) => usuarioStore.usuario == null
            ? LoginView(
                notice: '',
              )
            : (usuarioStore.usuario.primeiroAcesso == null
                ? LoginView(
                    notice: '',
                  )
                : fluxoLogin()),
      );
    }
  }
}
