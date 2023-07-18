// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessagesController on MessagesControllerBase, Store {
  late final _$messageAtom =
      Atom(name: 'MessagesControllerBase.message', context: context);

  @override
  Message get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(Message value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: 'MessagesControllerBase.messages', context: context);

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$recentMessagesAtom =
      Atom(name: 'MessagesControllerBase.recentMessages', context: context);

  @override
  ObservableList<Message> get recentMessages {
    _$recentMessagesAtom.reportRead();
    return super.recentMessages;
  }

  @override
  set recentMessages(ObservableList<Message> value) {
    _$recentMessagesAtom.reportWrite(value, super.recentMessages, () {
      super.recentMessages = value;
    });
  }

  late final _$auxListAtom =
      Atom(name: 'MessagesControllerBase.auxList', context: context);

  @override
  ObservableList<Message> get auxList {
    _$auxListAtom.reportRead();
    return super.auxList;
  }

  @override
  set auxList(ObservableList<Message> value) {
    _$auxListAtom.reportWrite(value, super.auxList, () {
      super.auxList = value;
    });
  }

  late final _$filteredListAtom =
      Atom(name: 'MessagesControllerBase.filteredList', context: context);

  @override
  ObservableList<Message> get filteredList {
    _$filteredListAtom.reportRead();
    return super.filteredList;
  }

  @override
  set filteredList(ObservableList<Message> value) {
    _$filteredListAtom.reportWrite(value, super.filteredList, () {
      super.filteredList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'MessagesControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$countMessageAtom =
      Atom(name: 'MessagesControllerBase.countMessage', context: context);

  @override
  int get countMessage {
    _$countMessageAtom.reportRead();
    return super.countMessage;
  }

  @override
  set countMessage(int value) {
    _$countMessageAtom.reportWrite(value, super.countMessage, () {
      super.countMessage = value;
    });
  }

  late final _$countMessageSMEAtom =
      Atom(name: 'MessagesControllerBase.countMessageSME', context: context);

  @override
  int get countMessageSME {
    _$countMessageSMEAtom.reportRead();
    return super.countMessageSME;
  }

  @override
  set countMessageSME(int value) {
    _$countMessageSMEAtom.reportWrite(value, super.countMessageSME, () {
      super.countMessageSME = value;
    });
  }

  late final _$countMessageUEAtom =
      Atom(name: 'MessagesControllerBase.countMessageUE', context: context);

  @override
  int get countMessageUE {
    _$countMessageUEAtom.reportRead();
    return super.countMessageUE;
  }

  @override
  set countMessageUE(int value) {
    _$countMessageUEAtom.reportWrite(value, super.countMessageUE, () {
      super.countMessageUE = value;
    });
  }

  late final _$countMessageDREAtom =
      Atom(name: 'MessagesControllerBase.countMessageDRE', context: context);

  @override
  int get countMessageDRE {
    _$countMessageDREAtom.reportRead();
    return super.countMessageDRE;
  }

  @override
  set countMessageDRE(int value) {
    _$countMessageDREAtom.reportWrite(value, super.countMessageDRE, () {
      super.countMessageDRE = value;
    });
  }

  late final _$messageIsReadAtom =
      Atom(name: 'MessagesControllerBase.messageIsRead', context: context);

  @override
  bool get messageIsRead {
    _$messageIsReadAtom.reportRead();
    return super.messageIsRead;
  }

  @override
  set messageIsRead(bool value) {
    _$messageIsReadAtom.reportWrite(value, super.messageIsRead, () {
      super.messageIsRead = value;
    });
  }

  late final _$loadMessagesAsyncAction =
      AsyncAction('MessagesControllerBase.loadMessages', context: context);

  @override
  Future loadMessages(int codigoAlunoEol, int userId) {
    return _$loadMessagesAsyncAction
        .run(() => super.loadMessages(codigoAlunoEol, userId));
  }

  late final _$loadByIdAsyncAction =
      AsyncAction('MessagesControllerBase.loadById', context: context);

  @override
  Future loadById(int messageId, int userId) {
    return _$loadByIdAsyncAction.run(() => super.loadById(messageId, userId));
  }

  late final _$deleteMessageAsyncAction =
      AsyncAction('MessagesControllerBase.deleteMessage', context: context);

  @override
  Future deleteMessage(int codigoEol, int idNotificacao, int userId) {
    return _$deleteMessageAsyncAction
        .run(() => super.deleteMessage(codigoEol, idNotificacao, userId));
  }

  late final _$updateMessageAsyncAction =
      AsyncAction('MessagesControllerBase.updateMessage', context: context);

  @override
  Future updateMessage(
      {required int notificacaoId,
      required int usuarioId,
      required int codigoAlunoEol,
      required bool mensagemVisualia}) {
    return _$updateMessageAsyncAction.run(() => super.updateMessage(
        notificacaoId: notificacaoId,
        usuarioId: usuarioId,
        codigoAlunoEol: codigoAlunoEol,
        mensagemVisualia: mensagemVisualia));
  }

  late final _$MessagesControllerBaseActionController =
      ActionController(name: 'MessagesControllerBase', context: context);

  @override
  dynamic loadMessageToFilters(bool dreCheck, bool smeCheck, bool ueCheck) {
    final _$actionInfo = _$MessagesControllerBaseActionController.startAction(
        name: 'MessagesControllerBase.loadMessageToFilters');
    try {
      return super.loadMessageToFilters(dreCheck, smeCheck, ueCheck);
    } finally {
      _$MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadRecentMessagesPorCategory() {
    final _$actionInfo = _$MessagesControllerBaseActionController.startAction(
        name: 'MessagesControllerBase.loadRecentMessagesPorCategory');
    try {
      return super.loadRecentMessagesPorCategory();
    } finally {
      _$MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterItems(bool dreCheck, bool smeCheck, bool ueCheck) {
    final _$actionInfo = _$MessagesControllerBaseActionController.startAction(
        name: 'MessagesControllerBase.filterItems');
    try {
      return super.filterItems(dreCheck, smeCheck, ueCheck);
    } finally {
      _$MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
messages: ${messages},
recentMessages: ${recentMessages},
auxList: ${auxList},
filteredList: ${filteredList},
isLoading: ${isLoading},
countMessage: ${countMessage},
countMessageSME: ${countMessageSME},
countMessageUE: ${countMessageUE},
countMessageDRE: ${countMessageDRE},
messageIsRead: ${messageIsRead}
    ''';
  }
}
