import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';

part 'messages.controller.g.dart';

class MessagesController = MessagesControllerBase with _$MessagesController;

abstract class MessagesControllerBase with Store {
  final MessageRepository _messagesRepository;

  MessagesControllerBase(this._messagesRepository);

  @observable
  late Message message;

  @observable
  late ObservableList<Message> messages;

  @observable
  late ObservableList<Message> recentMessages;

  @observable
  late ObservableList<Message> auxList = ObservableList<Message>();

  @observable
  late ObservableList<Message> filteredList = ObservableList<Message>();

  @observable
  bool isLoading = false;

  @observable
  late int countMessage;

  @observable
  late int countMessageSME;

  @observable
  late int countMessageUE;

  @observable
  late int countMessageDRE;

  @observable
  bool messageIsRead = false;

  @action
  loadMessages(int codigoAlunoEol, int userId) async {
    isLoading = true;
    var retorno = await _messagesRepository.fetchMessages(codigoAlunoEol, userId);
    messages = ObservableList<Message>.of(retorno);

    isLoading = false;
  }

  @action
  loadById(int messageId, int userId) async {
    isLoading = true;
    final messageReceived = await _messagesRepository.getMessageById(messageId, userId);
    message = messageReceived;
    isLoading = false;
  }

  @action
  loadMessageToFilters(bool dreCheck, bool smeCheck, bool ueCheck) {
    filterItems(dreCheck, smeCheck, ueCheck);
  }

  @action
  deleteMessage(int codigoEol, int idNotificacao, int userId) async {
    isLoading = true;
    _messagesRepository.deleteMessage(codigoEol, idNotificacao, userId);
    isLoading = false;
  }

  @action
  void loadRecentMessagesPorCategory() {
    final messagesUe = ObservableList<Message>.of(messages.where((e) => e.categoriaNotificacao == "UE").toList());
    countMessageUE = messagesUe.length;

    final messagesSME = ObservableList<Message>.of(messages.where((e) => e.categoriaNotificacao == "SME").toList());
    countMessageSME = messagesSME.length;

    final messagesDRE = ObservableList<Message>.of(messages.where((e) => e.categoriaNotificacao == "DRE").toList());
    countMessageDRE = messagesDRE.length;

    final list = ObservableList<Message>();

    if (countMessageSME > 0) {
      list.add(messagesSME.first);
    }

    if (countMessageDRE > 0) {
      list.add(messagesDRE.first);
    }

    if (countMessageUE > 0) {
      list.add(messagesUe.first);
    }

    recentMessages = ObservableList<Message>.of(list);
  }

  @action
  void filterItems(bool dreCheck, bool smeCheck, bool ueCheck) {
    var auxList = ObservableList<Message>();
    if (smeCheck && ueCheck && dreCheck) {
      final condition1 = ObservableList<Message>.of(messages);
      condition1.forEach((element) {
        print("condition1");
        print(element);
        print("condition1");
      });
      auxList = ObservableList<Message>.of(condition1);
    } else if (smeCheck && ueCheck && !dreCheck) {
      final condition2 = ObservableList<Message>.of(messages.where((e) => e.categoriaNotificacao != "DRE").toList());
      condition2.forEach((element) {
        print("condition2");
        print(element);
        print("condition2");
      });
      auxList = ObservableList<Message>.of(condition2);
    } else if (smeCheck && !ueCheck && dreCheck) {
      final condition3 =
          ObservableList<Message>.of(messages).where((element) => element.categoriaNotificacao != "UE").toList();
      condition3.forEach((element) {
        print("condition3");
        print(element);
        print("condition3");
      });
      auxList = ObservableList<Message>.of(condition3);
    } else if (smeCheck && !ueCheck && !dreCheck) {
      final condition4 =
          ObservableList<Message>.of(messages).where((element) => element.categoriaNotificacao == "SME").toList();
      condition4.forEach((element) {
        print("condition4");
        print(element);
        print("condition4");
      });
      auxList = ObservableList<Message>.of(condition4);
    } else if (!smeCheck && ueCheck && dreCheck) {
      final condition5 =
          ObservableList<Message>.of(messages).where((element) => element.categoriaNotificacao != "SME").toList();
      condition5.forEach((element) {
        print("condition5");
        print(element);
        print("condition5");
      });
      auxList = ObservableList<Message>.of(condition5);
    } else if (!smeCheck && ueCheck && !dreCheck) {
      final condition6 =
          ObservableList<Message>.of(messages).where((element) => element.categoriaNotificacao == "UE").toList();
      condition6.forEach((element) {
        print("condition6");
        print(element);
        print("condition6");
      });
      auxList = ObservableList<Message>.of(condition6);
    } else if (!smeCheck && !ueCheck && dreCheck) {
      final condition7 =
          ObservableList<Message>.of(messages).where((element) => element.categoriaNotificacao == "DRE").toList();

      condition7.forEach((element) {
        print("condition7");
        print(element);
        print("condition7");
      });

      auxList = ObservableList<Message>.of(condition7);
    } else if (!smeCheck && !ueCheck && !dreCheck) {
      final condition8 = ObservableList<Message>.of([]);
      auxList = ObservableList<Message>.of(condition8);
    }

    auxList.sort((b, a) => DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));

    filteredList = ObservableList.of(auxList);
  }

  @action
  updateMessage({
    required int notificacaoId,
    required int usuarioId,
    required int codigoAlunoEol,
    required bool mensagemVisualia,
    required EstudanteModel estudante,
  }) async {
    await _messagesRepository.readMessage(notificacaoId, usuarioId, codigoAlunoEol, mensagemVisualia);
  }
}
