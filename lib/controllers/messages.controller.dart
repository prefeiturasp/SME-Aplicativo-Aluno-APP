import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';
import 'package:sme_app_aluno/utils/storage.dart';

part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  MessageRepository _messagesRepository;
  Storage _storage;

  _MessagesControllerBase() {
    _messagesRepository = MessageRepository();
    _storage = Storage();
  }

  @observable
  ObservableList<Message> messages;

  @observable
  ObservableList<Message> recentMessages;

  @observable
  Message message;

  @observable
  ObservableList<Message> groupmessages;

  @observable
  ObservableList<Message> messagesNotDeleted;

  @observable
  ObservableList<dynamic> auxList = ObservableList<dynamic>();

  @observable
  bool isLoading = false;

  @observable
  int countMessage;

  @observable
  int countMessageSME;

  @observable
  int countMessageUE;

  @observable
  int countMessageTurma;

  @action
  loadMessage(int id) {
    message = messages.where((element) => element.id == id).toList().first;
  }

  @action
  messagesPerGroups(codigoGrupo) {
    if (messages != null) {
      groupmessages = ObservableList<Message>.of(messages
          .where(
            (m) => m.grupos.any((g) => g.codigo == codigoGrupo),
          )
          .toList());
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
  loadRecentMessagesPorCategory() async {
    if (messagesNotDeleted != null) {
      var messagesUe = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "UE")
          .toList());
      countMessageUE = messagesUe.length;

      var messagesSME = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "SME")
          .toList());
      countMessageSME = messagesSME.length;

      var messagesTurma = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "TURMA")
          .toList());
      countMessageTurma = messagesTurma.length;

      recentMessages = ObservableList<Message>.of(
          [messagesUe.first, messagesSME.first, messagesTurma.first]);
    }
  }

  @action
  filterItems(String filter) async {
    if (messagesNotDeleted != null) {
      auxList = ObservableList<Message>.of(messagesNotDeleted
          .where((message) => message.categoriaNotificacao != filter)
          .toList());
      messagesNotDeleted.clear();
      messagesNotDeleted = auxList;
    }
  }

  @action
  loadMessages() async {
    String token = await _storage.readValueStorage("token");
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    isLoading = false;
  }

  @action
  updateMessage({
    int notificacaoId,
    int usuarioId,
    int codigoAlunoEol,
    bool mensagemVisualia,
  }) async {
    await _messagesRepository.readMessage(
        notificacaoId, usuarioId, codigoAlunoEol, mensagemVisualia);
    loadMessages();
  }
}
