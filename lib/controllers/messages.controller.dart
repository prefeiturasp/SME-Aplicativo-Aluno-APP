import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';

part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  MessageRepository _messagesRepository;
  FirebaseMessaging _firebaseMessaging;

  _MessagesControllerBase() {
    _messagesRepository = MessageRepository();
    _firebaseMessaging = FirebaseMessaging();
  }

  @observable
  ObservableList<Message> messages;

  @observable
  ObservableList<Message> groupmessages;

  @observable
  ObservableList<Message> messagesNotDeleted;

  @observable
  bool isLoading = false;

  @observable
  int countMessage;

  @observable
  bool isReadMessage = false;

  @action
  messagesPerGroups(codigoGrupo) {
    groupmessages = ObservableList<Message>.of(messages
        .where(
          (m) => m.grupos.any((g) => g.codigo == codigoGrupo),
        )
        .toList());
  }

  @action
  superscribeGroupIdToFirebase() {
    if ((messages?.length ?? 0) > 0) {
      messages.forEach((element) {
        print("Codigo: ${element.grupos[0].codigo}");
        _firebaseMessaging
            .subscribeToTopic(element.grupos[0].codigo.toString());
      });
    }
  }

  @action
  loadMessagesNotDeleteds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (groupmessages != null) {
      String currentName = prefs.getString("current_name");
      var _ids = prefs.getString("${currentName}_deleted_id") ?? "";
      messagesNotDeleted = ObservableList<Message>.of(
          groupmessages.where((e) => !_ids.contains(e.id.toString())).toList());
      countMessage = messagesNotDeleted.length;
    }
  }

  @action
  loadMessages({String token}) async {
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    superscribeGroupIdToFirebase();
    isLoading = false;
  }

  @action
  updateMessage({int id, int userId, String token}) async {
    await _messagesRepository.readMessage(id, userId, token);
    loadMessages(token: token);
  }
}
