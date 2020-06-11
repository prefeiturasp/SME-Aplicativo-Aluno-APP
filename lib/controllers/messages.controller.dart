import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';
import 'package:sme_app_aluno/utils/storage.dart';

part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  MessageRepository _messagesRepository;
  FirebaseMessaging _firebaseMessaging;
  Storage _storage;

  _MessagesControllerBase() {
    _messagesRepository = MessageRepository();
    _firebaseMessaging = FirebaseMessaging();
    _storage = Storage();
  }

  @observable
  ObservableList<Message> messages;

  @observable
  Message message;

  @observable
  ObservableList<Message> groupmessages;

  @observable
  ObservableList<Message> messagesNotDeleted;

  @observable
  bool isLoading = false;

  @observable
  int countMessage;

  @action
  loadMessage(int id) {
    message = messages.where((element) => element.id == id).toList().first;
  }

  @action
  messagesPerGroups(codigoGrupo) {
    groupmessages = ObservableList<Message>.of(messages
        .where(
          (m) => m.grupos.any((g) => g.codigo == codigoGrupo),
        )
        .toList());
  }

  @action
  subscribeGroupIdToFirebase() {
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
  loadMessages() async {
    String token = await _storage.readValueStorage("token");
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    subscribeGroupIdToFirebase();
    isLoading = false;
  }

  @action
  updateMessage({
    int notificacaoId,
    String cpfUsuario,
    bool mensagemVisualia,
  }) async {
    await _messagesRepository.readMessage(
        notificacaoId, cpfUsuario, mensagemVisualia);
    loadMessages();
  }
}
