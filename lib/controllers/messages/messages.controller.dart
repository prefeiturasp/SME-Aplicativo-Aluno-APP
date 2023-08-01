import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/message/message.dart';
import '../../repositories/message_repository.dart';

part 'messages.controller.g.dart';

class MessagesController = MessagesControllerBase with _$MessagesController;

abstract class MessagesControllerBase with Store {
  final MessageRepository _messagesRepository = MessageRepository();

  @observable
  Message? message;

  @observable
  ObservableList<Message>? messages;

  @observable
  ObservableList<Message>? recentMessages;

  @observable
  ObservableList<Message>? auxList;

  @observable
  ObservableList<Message>? filteredList;

  @observable
  bool isLoading = false;

  @observable
  int countMessage = 0;

  @observable
  int countMessageSME = 0;

  @observable
  int countMessageUE = 0;

  @observable
  int countMessageDRE = 0;

  @observable
  bool messageIsRead = false;

  @action
  Future<void> loadMessages(int codigoAlunoEol, int userId) async {
    isLoading = true;
    final retorno = await _messagesRepository.fetchMessages(codigoAlunoEol, userId);
    messages = ObservableList<Message>.of(retorno);

    isLoading = false;
  }

  @action
  Future<void> loadById(int messageId, int userId) async {
    isLoading = true;
    final messageReceived = await _messagesRepository.getMessageById(messageId, userId);
    message = messageReceived;
    isLoading = false;
  }

  @action
  void loadMessageToFilters(bool dreCheck, bool smeCheck, bool ueCheck) {
    filterItems(dreCheck, smeCheck, ueCheck);
  }

  @action
  Future<void> deleteMessage(int codigoEol, int idNotificacao, int userId) async {
    isLoading = true;
    _messagesRepository.deleteMessage(codigoEol, idNotificacao, userId);
    isLoading = false;
  }

  @action
  void loadRecentMessagesPorCategory() {
    final messagesUe = ObservableList<Message>.of(messages!.where((e) => e.categoriaNotificacao == 'UE').toList());
    countMessageUE = messagesUe.length;

    final messagesSME = ObservableList<Message>.of(messages!.where((e) => e.categoriaNotificacao == 'SME').toList());
    countMessageSME = messagesSME.length;

    final messagesDRE = ObservableList<Message>.of(messages!.where((e) => e.categoriaNotificacao == 'DRE').toList());
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
      final condition1 = messages ?? ObservableList<Message>.of(messages!);
      for (var element in condition1) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition1);
    } else if (smeCheck && ueCheck && !dreCheck) {
      final condition2 = ObservableList<Message>.of(messages!.where((e) => e.categoriaNotificacao != 'DRE').toList());
      for (var element in condition2) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition2);
    } else if (smeCheck && !ueCheck && dreCheck) {
      final condition3 = messages ??
          ObservableList<Message>.of(messages!).where((element) => element.categoriaNotificacao != 'UE').toList();
      for (var element in condition3) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition3);
    } else if (smeCheck && !ueCheck && !dreCheck) {
      final condition4 = messages ??
          ObservableList<Message>.of(messages!).where((element) => element.categoriaNotificacao == 'SME').toList();
      for (var element in condition4) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition4);
    } else if (!smeCheck && ueCheck && dreCheck) {
      final condition5 = messages ??
          ObservableList<Message>.of(messages!).where((element) => element.categoriaNotificacao != 'SME').toList();
      for (var element in condition5) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition5);
    } else if (!smeCheck && ueCheck && !dreCheck) {
      final condition6 = messages ??
          ObservableList<Message>.of(messages!).where((element) => element.categoriaNotificacao == 'UE').toList();
      for (var element in condition6) {
        log(element.toString());
      }
      auxList = ObservableList<Message>.of(condition6);
    } else if (!smeCheck && !ueCheck && dreCheck) {
      final condition7 = messages ??
          ObservableList<Message>.of(messages!).where((element) => element.categoriaNotificacao == 'DRE').toList();

      for (var element in condition7) {
        log(element.toString());
      }

      auxList = ObservableList<Message>.of(condition7);
    } else if (!smeCheck && !ueCheck && !dreCheck) {
      final condition8 = ObservableList<Message>.of([]);
      auxList = ObservableList<Message>.of(condition8);
    }

    auxList.sort((b, a) => DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));

    filteredList = ObservableList.of(auxList);
  }

  @action
  Future<void> updateMessage({
    required int notificacaoId,
    required int usuarioId,
    required int codigoAlunoEol,
    required bool mensagemVisualia,
  }) async {
    await _messagesRepository.readMessage(notificacaoId, usuarioId, codigoAlunoEol, mensagemVisualia);
  }
}
