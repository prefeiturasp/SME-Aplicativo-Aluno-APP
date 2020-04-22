// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesController on _MessagesControllerBase, Store {
  final _$messagesAtom = Atom(name: '_MessagesControllerBase.messages');

  @override
  List<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(List<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
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

  final _$loadMessagesAsyncAction = AsyncAction('loadMessages');

  @override
  Future<List<Message>> loadMessages(String token) {
    return _$loadMessagesAsyncAction.run(() => super.loadMessages(token));
  }

  @override
  String toString() {
    final string =
        'messages: ${messages.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
