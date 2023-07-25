import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/message/group.dart';
import '../models/message/message.dart';
import '../services/group_messages.service.dart';
import '../services/message.service.dart';
import '../services/user.service.dart';
import '../stores/index.dart';
import '../ui/views/login.view.dart';
import 'navigator.dart';

class Auth {
  static Future<void> logout(BuildContext context, int userId, bool desconected) async {
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final UserService userService = UserService();
      final MessageService messageService = MessageService();
      final GroupMessageService groupMessageService = GroupMessageService();
      final usuarioStore = GetIt.I.get<UsuarioStore>();

      final List<Group> groups = await groupMessageService.all();
      final List<Message> messages = await messageService.all();

      groups.forEach((element) async {
        log('Grupo removido: ${element.toMap()}');
        await firebaseMessaging.unsubscribeFromTopic(element.codigo);
        await groupMessageService.delete(element.id);
      });

      messages.forEach((message) async {
        log('Mensagem removida: ${message.toMap()}');
        await messageService.delete(message.id);
      });

      await userService.delete(userId);

      BackgroundFetch.stop().then((int status) {
        log('[BackgroundFetch] stop success: $status');
      });

      usuarioStore.limparUsuario();

      if (context.mounted) {
        voltarLogin(context, desconected);
      }
    } on Exception {
      voltarLogin(context, desconected);
    }
  }

  static void voltarLogin(BuildContext context, bool desconected) {
    Nav.push(
      context,
      desconected
          ? const LoginView(
              notice:
                  'Você foi desconectado pois não está mais vinculado como responsável de nenhum estudante ativo. Dúvidas entre em contato com a Unidade Escolar.',
            )
          : const LoginView(
              notice: '',
            ),
    );
  }
}
