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

  @action
  loadMessages() async {
    String token = await _storage.readValueStorage("token");
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    isLoading = false;
  }

  @action
  loadMessageToFilters(bool turmaCheck, bool smeCheck, bool ueCheck) {
    loadMessagesNotDeleteds();
    filterItems(turmaCheck, smeCheck, ueCheck);
  }

  @action
  loadMessagesNotDeleteds() async {
    if (messages != null) {
      final currentName = await _storage.readValueStorage("current_name");
      final _ids =
          await _storage.readValueStorage("${currentName}_deleted_id") ?? "";
      messagesNotDeleted = ObservableList<Message>.of(
          messages.where((e) => !_ids.contains(e.id.toString())).toList());
      countMessage = messagesNotDeleted.length;
    }
  }

  @action
  void loadRecentMessagesPorCategory() {
    if (messagesNotDeleted != null) {
      final messagesUe = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "UE")
          .toList());
      countMessageUE = messagesUe.length;

      final messagesSME = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "SME")
          .toList());
      countMessageSME = messagesSME.length;

      final messagesTurma = ObservableList<Message>.of(messagesNotDeleted
          .where((e) => e.categoriaNotificacao == "TURMA")
          .toList());
      countMessageTurma = messagesTurma.length;

      final list = ObservableList<Message>();

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
  void filterItems(bool turmaCheck, bool smeCheck, bool ueCheck) {
    if (messagesNotDeleted != null) {
      var auxList = ObservableList<Message>();
      if (smeCheck && ueCheck && turmaCheck) {
        final condition1 = ObservableList<Message>.of(messagesNotDeleted);
        auxList = ObservableList<Message>.of(condition1);
      } else if (smeCheck && ueCheck && !turmaCheck) {
        final condition2 = ObservableList<Message>.of(messagesNotDeleted
            .where((e) => e.categoriaNotificacao != "TURMA")
            .toList());
        auxList = ObservableList<Message>.of(condition2);
      } else if (smeCheck && !ueCheck && turmaCheck) {
        final condition3 = ObservableList<Message>.of(messagesNotDeleted)
            .where((element) => element.categoriaNotificacao != "UE")
            .toList();
        auxList = ObservableList<Message>.of(condition3);
      } else if (smeCheck && !ueCheck && !turmaCheck) {
        final condition4 = ObservableList<Message>.of(messagesNotDeleted)
            .where((element) => element.categoriaNotificacao == "SME")
            .toList();
        auxList = ObservableList<Message>.of(condition4);
      } else if (!smeCheck && ueCheck && turmaCheck) {
        final condition5 = ObservableList<Message>.of(messagesNotDeleted)
            .where((element) => element.categoriaNotificacao != "SME")
            .toList();
        auxList = ObservableList<Message>.of(condition5);
      } else if (!smeCheck && ueCheck && !turmaCheck) {
        final condition6 = ObservableList<Message>.of(messagesNotDeleted)
            .where((element) => element.categoriaNotificacao == "UE")
            .toList();
        auxList = ObservableList<Message>.of(condition6);
      } else if (!smeCheck && !ueCheck && turmaCheck) {
        final condition7 = ObservableList<Message>.of(messagesNotDeleted)
            .where((element) => element.categoriaNotificacao == "TURMA")
            .toList();
        auxList = ObservableList<Message>.of(condition7);
      } else if (!smeCheck && !ueCheck && !turmaCheck) {
        final condition8 = ObservableList<Message>.of([]);
        auxList = ObservableList<Message>.of(condition8);
      }

      filteredList = ObservableList.of(auxList);
    }
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
  }
}
