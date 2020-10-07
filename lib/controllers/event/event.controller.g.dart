// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventController on _EventControllerBase, Store {
  final _$eventAtom = Atom(name: '_EventControllerBase.event');

  @override
  Event get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(Event value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  final _$eventsAtom = Atom(name: '_EventControllerBase.events');

  @override
  ObservableList<Event> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<Event> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EventControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$fetchEventoAsyncAction =
      AsyncAction('_EventControllerBase.fetchEvento');

  @override
  Future fetchEvento(int codigoAluno, int mes, int ano, int userId) {
    return _$fetchEventoAsyncAction
        .run(() => super.fetchEvento(codigoAluno, mes, ano, userId));
  }

  @override
  String toString() {
    return '''
event: ${event},
events: ${events},
loading: ${loading}
    ''';
  }
}
