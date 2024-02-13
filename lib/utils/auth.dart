import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/message/group.dart';
import '../models/message/message.dart';
import '../services/group_messages.service.dart';
import '../services/message.service.dart';
import '../stores/index.dart';
import '../ui/views/login.view.dart';
import 'navigator.dart';

class Auth {
  static Future<void> logout(BuildContext context, int userId, bool desconected) async {
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final MessageService messageService = MessageService();
      final GroupMessageService groupMessageService = GroupMessageService();
      final usuarioStore = GetIt.I.get<UsuarioStore>();

      final List<Group> groups = await groupMessageService.all();
      final List<Message> messages = await messageService.all();

      for (var i = 0; i < groups.length; i++) {
        await firebaseMessaging.unsubscribeFromTopic(groups[i].codigo);
        await groupMessageService.delete(groups[i].id);
      }

      for (var i = 0; i < messages.length; i++) {
        await messageService.delete(messages[i].id);
      }

      await usuarioStore.limparUsuario();

      BackgroundFetch.stop().then((int status) {
        log('[BackgroundFetch] stop success: $status');
      });

      if (context.mounted) {
        voltarLogin(context, desconected);
      }
    } on Exception {
      if (context.mounted) {
        voltarLogin(context, desconected);
      }
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
              notice: null,
            ),
    );
  }
}
