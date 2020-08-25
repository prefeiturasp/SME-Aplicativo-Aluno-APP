// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesController on _MessagesControllerBase, Store {
  final _$messageAtom = Atom(name: '_MessagesControllerBase.message');

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

  final _$messagesAtom = Atom(name: '_MessagesControllerBase.messages');

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

  final _$recentMessagesAtom =
      Atom(name: '_MessagesControllerBase.recentMessages');

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

  final _$messagesNotDeletedAtom =
      Atom(name: '_MessagesControllerBase.messagesNotDeleted');

  @override
  ObservableList<Message> get messagesNotDeleted {
    _$messagesNotDeletedAtom.reportRead();
    return super.messagesNotDeleted;
  }

  @override
  set messagesNotDeleted(ObservableList<Message> value) {
    _$messagesNotDeletedAtom.reportWrite(value, super.messagesNotDeleted, () {
      super.messagesNotDeleted = value;
    });
  }

  final _$auxListAtom = Atom(name: '_MessagesControllerBase.auxList');

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

  final _$filteredListAtom = Atom(name: '_MessagesControllerBase.filteredList');

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

  final _$isLoadingAtom = Atom(name: '_MessagesControllerBase.isLoading');

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

  final _$countMessageAtom = Atom(name: '_MessagesControllerBase.countMessage');

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

  final _$countMessageSMEAtom =
      Atom(name: '_MessagesControllerBase.countMessageSME');

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

  final _$countMessageUEAtom =
      Atom(name: '_MessagesControllerBase.countMessageUE');

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

  final _$countMessageTurmaAtom =
      Atom(name: '_MessagesControllerBase.countMessageTurma');

  @override
  int get countMessageTurma {
    _$countMessageTurmaAtom.reportRead();
    return super.countMessageTurma;
  }

  @override
  set countMessageTurma(int value) {
    _$countMessageTurmaAtom.reportWrite(value, super.countMessageTurma, () {
      super.countMessageTurma = value;
    });
  }

  final _$messageIsReadAtom =
      Atom(name: '_MessagesControllerBase.messageIsRead');

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

  final _$loadMessagesAsyncAction =
      AsyncAction('_MessagesControllerBase.loadMessages');

  @override
  Future loadMessages(int codigoAlunoEol, int userId) {
    return _$loadMessagesAsyncAction
        .run(() => super.loadMessages(codigoAlunoEol, userId));
  }

  final _$loadMessagesNotDeletedsAsyncAction =
      AsyncAction('_MessagesControllerBase.loadMessagesNotDeleteds');

  @override
  Future loadMessagesNotDeleteds() {
    return _$loadMessagesNotDeletedsAsyncAction
        .run(() => super.loadMessagesNotDeleteds());
  }

  final _$updateMessageAsyncAction =
      AsyncAction('_MessagesControllerBase.updateMessage');

  @override
  Future updateMessage(
      {int notificacaoId,
      int usuarioId,
      int codigoAlunoEol,
      bool mensagemVisualia,
      Student student}) {
    return _$updateMessageAsyncAction.run(() => super.updateMessage(
        notificacaoId: notificacaoId,
        usuarioId: usuarioId,
        codigoAlunoEol: codigoAlunoEol,
        mensagemVisualia: mensagemVisualia,
        student: student));
  }

  final _$_MessagesControllerBaseActionController =
      ActionController(name: '_MessagesControllerBase');

  @override
  dynamic loadMessageToFilters(bool turmaCheck, bool smeCheck, bool ueCheck) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.loadMessageToFilters');
    try {
      return super.loadMessageToFilters(turmaCheck, smeCheck, ueCheck);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadRecentMessagesPorCategory() {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.loadRecentMessagesPorCategory');
    try {
      return super.loadRecentMessagesPorCategory();
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterItems(bool turmaCheck, bool smeCheck, bool ueCheck) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.filterItems');
    try {
      return super.filterItems(turmaCheck, smeCheck, ueCheck);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
messages: ${messages},
recentMessages: ${recentMessages},
messagesNotDeleted: ${messagesNotDeleted},
auxList: ${auxList},
filteredList: ${filteredList},
isLoading: ${isLoading},
countMessage: ${countMessage},
countMessageSME: ${countMessageSME},
countMessageUE: ${countMessageUE},
countMessageTurma: ${countMessageTurma},
messageIsRead: ${messageIsRead}
    ''';
  }
}
