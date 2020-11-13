import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/models/message/group.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/services/group_messages.service.dart';
import 'package:sme_app_aluno/services/message.service.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Auth {
  static logout(BuildContext context, int userId) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    final UserService _userService = UserService();
    final MessageService _messageService = MessageService();
    final GroupMessageService _groupMessageService = GroupMessageService();

    List<Group> groups = await _groupMessageService.all();
    List<Message> messages = await _messageService.all();

    groups.forEach((element) async {
      print("Grupo removido: ${element.toMap()}");
      await _firebaseMessaging.unsubscribeFromTopic(element.codigo);
      await _groupMessageService.delete(element.id);
    });

    messages.forEach((message) async {
      print("Mensagem removida: ${message.toMap()}");
      await _messageService.delete(message.id);
    });

    await _userService.delete(userId);

    Nav.push(context, Login());
  }
}
