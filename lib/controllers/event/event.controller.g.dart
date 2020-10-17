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

  final _$priorityEventsAtom =
      Atom(name: '_EventControllerBase.priorityEvents');

  @override
  ObservableList<Event> get priorityEvents {
    _$priorityEventsAtom.reportRead();
    return super.priorityEvents;
  }

  @override
  set priorityEvents(ObservableList<Event> value) {
    _$priorityEventsAtom.reportWrite(value, super.priorityEvents, () {
      super.priorityEvents = value;
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

  final _$currentDateAtom = Atom(name: '_EventControllerBase.currentDate');

  @override
  DateTime get currentDate {
    _$currentDateAtom.reportRead();
    return super.currentDate;
  }

  @override
  set currentDate(DateTime value) {
    _$currentDateAtom.reportWrite(value, super.currentDate, () {
      super.currentDate = value;
    });
  }

  final _$currentMonthAtom = Atom(name: '_EventControllerBase.currentMonth');

  @override
  String get currentMonth {
    _$currentMonthAtom.reportRead();
    return super.currentMonth;
  }

  @override
  set currentMonth(String value) {
    _$currentMonthAtom.reportWrite(value, super.currentMonth, () {
      super.currentMonth = value;
    });
  }

  final _$fetchEventoAsyncAction =
      AsyncAction('_EventControllerBase.fetchEvento');

  @override
  Future fetchEvento(int codigoAluno, int mes, int ano, int userId) {
    return _$fetchEventoAsyncAction
        .run(() => super.fetchEvento(codigoAluno, mes, ano, userId));
  }

  final _$_EventControllerBaseActionController =
      ActionController(name: '_EventControllerBase');

  @override
  dynamic loadingCurrentMonth(dynamic month) {
    final _$actionInfo = _$_EventControllerBaseActionController.startAction(
        name: '_EventControllerBase.loadingCurrentMonth');
    try {
      return super.loadingCurrentMonth(month);
    } finally {
      _$_EventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listPriorityEvents(dynamic eventsList) {
    final _$actionInfo = _$_EventControllerBaseActionController.startAction(
        name: '_EventControllerBase.listPriorityEvents');
    try {
      return super.listPriorityEvents(eventsList);
    } finally {
      _$_EventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
event: ${event},
events: ${events},
priorityEvents: ${priorityEvents},
loading: ${loading},
currentDate: ${currentDate},
currentMonth: ${currentMonth}
    ''';
  }
}
