// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesController on _MessagesControllerBase, Store {
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

  final _$groupmessagesAtom =
      Atom(name: '_MessagesControllerBase.groupmessages');

  @override
  ObservableList<Message> get groupmessages {
    _$groupmessagesAtom.reportRead();
    return super.groupmessages;
  }

  @override
  set groupmessages(ObservableList<Message> value) {
    _$groupmessagesAtom.reportWrite(value, super.groupmessages, () {
      super.groupmessages = value;
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

  final _$loadMessagesNotDeletedsAsyncAction =
      AsyncAction('_MessagesControllerBase.loadMessagesNotDeleteds');

  @override
  Future loadMessagesNotDeleteds() {
    return _$loadMessagesNotDeletedsAsyncAction
        .run(() => super.loadMessagesNotDeleteds());
  }

  final _$loadRecentMessagesPorCategoryAsyncAction =
      AsyncAction('_MessagesControllerBase.loadRecentMessagesPorCategory');

  @override
  Future loadRecentMessagesPorCategory() {
    return _$loadRecentMessagesPorCategoryAsyncAction
        .run(() => super.loadRecentMessagesPorCategory());
  }

  final _$loadMessagesAsyncAction =
      AsyncAction('_MessagesControllerBase.loadMessages');

  @override
  Future loadMessages() {
    return _$loadMessagesAsyncAction.run(() => super.loadMessages());
  }

  final _$updateMessageAsyncAction =
      AsyncAction('_MessagesControllerBase.updateMessage');

  @override
  Future updateMessage(
      {int notificacaoId, String cpfUsuario, bool mensagemVisualia}) {
    return _$updateMessageAsyncAction.run(() => super.updateMessage(
        notificacaoId: notificacaoId,
        cpfUsuario: cpfUsuario,
        mensagemVisualia: mensagemVisualia));
  }

  final _$_MessagesControllerBaseActionController =
      ActionController(name: '_MessagesControllerBase');

  @override
  dynamic loadMessage(int id) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.loadMessage');
    try {
      return super.loadMessage(id);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic messagesPerGroups(dynamic codigoGrupo) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.messagesPerGroups');
    try {
      return super.messagesPerGroups(codigoGrupo);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messages: ${messages},
recentMessages: ${recentMessages},
message: ${message},
groupmessages: ${groupmessages},
messagesNotDeleted: ${messagesNotDeleted},
isLoading: ${isLoading},
countMessage: ${countMessage},
countMessageSME: ${countMessageSME},
countMessageUE: ${countMessageUE},
countMessageTurma: ${countMessageTurma}
    ''';
  }
}
