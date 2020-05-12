// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesController on _MessagesControllerBase, Store {
  final _$messagesAtom = Atom(name: '_MessagesControllerBase.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$groupmessagesAtom =
      Atom(name: '_MessagesControllerBase.groupmessages');

  @override
  ObservableList<Message> get groupmessages {
    _$groupmessagesAtom.context.enforceReadPolicy(_$groupmessagesAtom);
    _$groupmessagesAtom.reportObserved();
    return super.groupmessages;
  }

  @override
  set groupmessages(ObservableList<Message> value) {
    _$groupmessagesAtom.context.conditionallyRunInAction(() {
      super.groupmessages = value;
      _$groupmessagesAtom.reportChanged();
    }, _$groupmessagesAtom, name: '${_$groupmessagesAtom.name}_set');
  }

  final _$messagesNotDeletedAtom =
      Atom(name: '_MessagesControllerBase.messagesNotDeleted');

  @override
  ObservableList<Message> get messagesNotDeleted {
    _$messagesNotDeletedAtom.context
        .enforceReadPolicy(_$messagesNotDeletedAtom);
    _$messagesNotDeletedAtom.reportObserved();
    return super.messagesNotDeleted;
  }

  @override
  set messagesNotDeleted(ObservableList<Message> value) {
    _$messagesNotDeletedAtom.context.conditionallyRunInAction(() {
      super.messagesNotDeleted = value;
      _$messagesNotDeletedAtom.reportChanged();
    }, _$messagesNotDeletedAtom, name: '${_$messagesNotDeletedAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_MessagesControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$countMessageAtom = Atom(name: '_MessagesControllerBase.countMessage');

  @override
  int get countMessage {
    _$countMessageAtom.context.enforceReadPolicy(_$countMessageAtom);
    _$countMessageAtom.reportObserved();
    return super.countMessage;
  }

  @override
  set countMessage(int value) {
    _$countMessageAtom.context.conditionallyRunInAction(() {
      super.countMessage = value;
      _$countMessageAtom.reportChanged();
    }, _$countMessageAtom, name: '${_$countMessageAtom.name}_set');
  }

  final _$loadMessagesNotDeletedsAsyncAction =
      AsyncAction('loadMessagesNotDeleteds');

  @override
  Future loadMessagesNotDeleteds() {
    return _$loadMessagesNotDeletedsAsyncAction
        .run(() => super.loadMessagesNotDeleteds());
  }

  final _$loadMessagesAsyncAction = AsyncAction('loadMessages');

  @override
  Future loadMessages({String token}) {
    return _$loadMessagesAsyncAction
        .run(() => super.loadMessages(token: token));
  }

  final _$updateMessageAsyncAction = AsyncAction('updateMessage');

  @override
  Future updateMessage({int id, int userId, String token}) {
    return _$updateMessageAsyncAction
        .run(() => super.updateMessage(id: id, userId: userId, token: token));
  }

  final _$_MessagesControllerBaseActionController =
      ActionController(name: '_MessagesControllerBase');

  @override
  dynamic messagesPerGroups(dynamic codigoGrupo) {
    final _$actionInfo =
        _$_MessagesControllerBaseActionController.startAction();
    try {
      return super.messagesPerGroups(codigoGrupo);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'messages: ${messages.toString()},groupmessages: ${groupmessages.toString()},messagesNotDeleted: ${messagesNotDeleted.toString()},isLoading: ${isLoading.toString()},countMessage: ${countMessage.toString()}';
    return '{$string}';
  }
}
