import 'package:mobx/mobx.dart';
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
  Message message;

  @observable
  ObservableList<Message> messages;

  @observable
  ObservableList<Message> recentMessages;

  @observable
  ObservableList<Message> messagesNotDeleted;

  @observable
  ObservableList<Message> auxList = ObservableList<Message>();

  @observable
  ObservableList<Message> filteredList = ObservableList<Message>();

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

  @observable
  String filter = 'all';

  @action
  loadMessages() async {
    String token = await _storage.readValueStorage("token");
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    isLoading = false;
  }

  @action
  loadMessagesNotDeleteds() async {
    if (messages != null) {
      String currentName = await _storage.readValueStorage("current_name");
      var _ids =
          await _storage.readValueStorage("${currentName}_deleted_id") ?? "";
      messagesNotDeleted = ObservableList<Message>.of(
          messages.where((e) => !_ids.contains(e.id.toString())).toList());
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

      var list = ObservableList<Message>();

      if (countMessageUE > 0) {
        list.add(messagesUe.first);
      }

      if (countMessageSME > 0) {
        list.add(messagesSME.first);
      }

      if (countMessageTurma > 0) {
        list.add(messagesTurma.first);
      }

      recentMessages = ObservableList<Message>.of(list);
    }
  }

  @action
  filterItems(String filter) {
    auxList = ObservableList.of([]);
    this.filter = filter;
    if (filter == "all") {
      auxList = ObservableList.of(messagesNotDeleted);
    } else {
      messagesNotDeleted.forEach((element) {
        if (element is String) {
          if (element.categoriaNotificacao == filter) {
            auxList.add(element);
          }
        } else if (element.categoriaNotificacao == filter) {
          auxList.add(element);
        }
      });
    }
    filteredList = ObservableList.of(auxList);
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
