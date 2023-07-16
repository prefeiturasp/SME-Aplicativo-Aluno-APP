import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/models/message/group.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/views/login.view.dart';
import 'package:sme_app_aluno/services/group_messages.service.dart';
import 'package:sme_app_aluno/services/message.service.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Auth {
  static logout(BuildContext context, int userId, bool desconected) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    UserService _userService = UserService();
    MessageService _messageService = MessageService();
    GroupMessageService _groupMessageService = GroupMessageService();
    final usuarioStore = GetIt.I.get<UsuarioStore>();

    List<Group> groups = await _groupMessageService.all();
    List<Message> messages = await _messageService.all();

    groups.forEach((element) async {
      log("Grupo removido: ${element.toMap()}");
      await _firebaseMessaging.unsubscribeFromTopic(element.codigo);
      await _groupMessageService.delete(element.id);
    });

    messages.forEach((message) async {
      log("Mensagem removida: ${message.toMap()}");
      await _messageService.delete(message.id);
    });

    await _userService.delete(userId);

    BackgroundFetch.stop().then((int status) {
      log('[BackgroundFetch] stop success: $status');
    });

    usuarioStore.limparUsuario();

    Nav.push(
        context,
        desconected
            ? LoginView(
                notice:
                    "Você foi desconectado pois não está mais vinculado como responsável de nenhum estudante ativo. Dúvidas entre em contato com a Unidade Escolar.")
            : LoginView(
                notice: '',
              ));
  }
}
