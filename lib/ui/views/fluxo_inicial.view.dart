import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:provider/provider.dart';

import '../../controllers/autenticacao.controller.dart';
import '../../controllers/messages/messages.controller.dart';
import '../../models/message/message.dart';
import '../../screens/firstAccess/firstAccess.dart';
import '../../screens/messages/view_message_notification.dart';
import '../../screens/not_internet/not_internet.dart';
import '../../stores/usuario.store.dart';
import '../../utils/conection.dart';
import '../../utils/navigator.dart';
import '../index.dart';

class FluxoInicialView extends StatefulWidget {
  const FluxoInicialView({super.key});

  @override
  FluxoInicialViewState createState() => FluxoInicialViewState();
}

class FluxoInicialViewState extends State<FluxoInicialView> {
  UsuarioStore usuarioStore = GetIt.I.get<UsuarioStore>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final Stream<RemoteMessage> _firebaseonMessage = FirebaseMessaging.onMessage;
  final Stream<RemoteMessage> _firebaseonOnMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;

  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  MessagesController _messagesController = MessagesController();

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

  _initPushNotificationHandlers() async {
    try {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getToken().then(print);
      _firebaseMessaging.subscribeToTopic('AppAluno');
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
      //throw Exception(ex);
    }
  }

  _popUpNotification(Map<String, dynamic> message) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: "NOTIFICAÇÃO - ${message["data"]["categoriaNotificacao"]}",
      desc: 'Você acaba de receber uma \n mensagem.',
      btnOkOnPress: () {
        _navigateToMessageView(message);
      },
      btnOkText: 'VISUALIZAR',
    ).show();
  }

  _navigateToMessageView(Map<String, dynamic> message) async {
    final Message message0 = Message(
      id: int.parse(message['data']['Id']),
      titulo: message['data']['Titulo'],
      mensagem: message['data']['Mensagem'],
      criadoEm: message['data']['CriadoEm'],
      codigoEOL: message['data']['CodigoEOL'] != null ? int.parse(message['data']['CodigoEOL']) : 0,
      categoriaNotificacao: message['data']['categoriaNotificacao'],
      dataEnvio: message['data']['DataEnvio'],
      alteradoEm: message['data']['AlteradoEm'],
      mensagemVisualizada: message['data']['MensagemVisualizada'],
    );

    await _messagesController.loadById(message0.id, usuarioStore.usuario.id);
    message0.mensagem = _messagesController.message!.mensagem;
    Nav.push(
      context,
      ViewMessageNotification(
        message: message0,
        userId: usuarioStore.usuario.id,
      ),
    );
  }

  Widget fluxoLogin() {
    if (usuarioStore.usuario.primeiroAcesso) {
      return FirstAccess(
        id: usuarioStore.usuario.id,
        cpf: usuarioStore.usuario.cpf,
      );
    } else if (usuarioStore.usuario.atualizarDadosCadastrais) {
      return const AtualizacaoCadastralView();
    }
    // else {
    //   return EstudanteListaView();
    // }

    return const Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
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
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      return NotInteernet();
    } else {
      return Observer(
        builder: (context) => usuarioStore.usuario.id == 0
            ? const LoginView(
                notice: '',
              )
            : (usuarioStore.usuario.primeiroAcesso != false
                ? const LoginView(
                    notice: '',
                  )
                : fluxoLogin()),
      );
    }
  }
}
