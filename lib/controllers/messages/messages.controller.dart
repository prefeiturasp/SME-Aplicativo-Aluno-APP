import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';

part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  MessageRepository _messagesRepository;

  _MessagesControllerBase() {
    _messagesRepository = MessageRepository();
  }

  @observable
  Message message;

  @observable
  ObservableList<Message> messages;

  @observable
  ObservableList<Message> recentMessages;

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
  bool messageIsRead = false;

  @action
  loadMessages(int codigoAlunoEol, int userId) async {
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(codigoAlunoEol, userId));
    isLoading = false;
  }

  @action
  loadMessageToFilters(bool turmaCheck, bool smeCheck, bool ueCheck) {
    filterItems(turmaCheck, smeCheck, ueCheck);
  }

  @action
  deleteMessage(int codigoEol, int idNotificacao, int userId) async {
    isLoading = true;
    _messagesRepository.deleteMessage(codigoEol, idNotificacao, userId);
    isLoading = false;
  }

  @action
  void loadRecentMessagesPorCategory() {
    if (messages != null) {
      final messagesUe = ObservableList<Message>.of(
          messages.where((e) => e.categoriaNotificacao == "UE").toList());
      countMessageUE = messagesUe.length;

      final messagesSME = ObservableList<Message>.of(
          messages.where((e) => e.categoriaNotificacao == "SME").toList());
      countMessageSME = messagesSME.length;

      final messagesTurma = ObservableList<Message>.of(
          messages.where((e) => e.categoriaNotificacao == "TURMA").toList());
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
    if (messages != null) {
      var auxList = ObservableList<Message>();
      if (smeCheck && ueCheck && turmaCheck) {
        final condition1 = ObservableList<Message>.of(messages);
        condition1.forEach((element) {
          print("condition1");
          print(element);
          print("condition1");
        });
        auxList = ObservableList<Message>.of(condition1);
      } else if (smeCheck && ueCheck && !turmaCheck) {
        final condition2 = ObservableList<Message>.of(
            messages.where((e) => e.categoriaNotificacao != "TURMA").toList());
        condition2.forEach((element) {
          print("condition2");
          print(element);
          print("condition2");
        });
        auxList = ObservableList<Message>.of(condition2);
      } else if (smeCheck && !ueCheck && turmaCheck) {
        final condition3 = ObservableList<Message>.of(messages)
            .where((element) => element.categoriaNotificacao != "UE")
            .toList();
        condition3.forEach((element) {
          print("condition3");
          print(element);
          print("condition3");
        });
        auxList = ObservableList<Message>.of(condition3);
      } else if (smeCheck && !ueCheck && !turmaCheck) {
        final condition4 = ObservableList<Message>.of(messages)
            .where((element) => element.categoriaNotificacao == "SME")
            .toList();
        condition4.forEach((element) {
          print("condition4");
          print(element);
          print("condition4");
        });
        auxList = ObservableList<Message>.of(condition4);
      } else if (!smeCheck && ueCheck && turmaCheck) {
        final condition5 = ObservableList<Message>.of(messages)
            .where((element) => element.categoriaNotificacao != "SME")
            .toList();
        condition5.forEach((element) {
          print("condition5");
          print(element);
          print("condition5");
        });
        auxList = ObservableList<Message>.of(condition5);
      } else if (!smeCheck && ueCheck && !turmaCheck) {
        final condition6 = ObservableList<Message>.of(messages)
            .where((element) => element.categoriaNotificacao == "UE")
            .toList();
        condition6.forEach((element) {
          print("condition6");
          print(element);
          print("condition6");
        });
        auxList = ObservableList<Message>.of(condition6);
      } else if (!smeCheck && !ueCheck && turmaCheck) {
        final condition7 = ObservableList<Message>.of(messages)
            .where((element) => element.categoriaNotificacao == "TURMA")
            .toList();

        condition7.forEach((element) {
          print("condition7");
          print(element);
          print("condition7");
        });

        auxList = ObservableList<Message>.of(condition7);
      } else if (!smeCheck && !ueCheck && !turmaCheck) {
        final condition8 = ObservableList<Message>.of([]);
        auxList = ObservableList<Message>.of(condition8);
      }

      auxList.sort((b, a) =>
          DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));

      filteredList = ObservableList.of(auxList);
    }
  }

  @action
  updateMessage({
    int notificacaoId,
    int usuarioId,
    int codigoAlunoEol,
    bool mensagemVisualia,
    Student student,
  }) async {
    await _messagesRepository.readMessage(
        notificacaoId, usuarioId, codigoAlunoEol, mensagemVisualia);
  }
}
