// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventController on EventControllerBase, Store {
  late final _$eventAtom = Atom(
    name: 'EventControllerBase.event',
    context: context,
  );

  @override
  Event? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(Event? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$eventsAtom = Atom(
    name: 'EventControllerBase.events',
    context: context,
  );

  @override
  ObservableList<Event>? get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<Event>? value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$eventsSortDateAtom = Atom(
    name: 'EventControllerBase.eventsSortDate',
    context: context,
  );

  @override
  ObservableList<Event>? get eventsSortDate {
    _$eventsSortDateAtom.reportRead();
    return super.eventsSortDate;
  }

  @override
  set eventsSortDate(ObservableList<Event>? value) {
    _$eventsSortDateAtom.reportWrite(value, super.eventsSortDate, () {
      super.eventsSortDate = value;
    });
  }

  late final _$priorityEventsAtom = Atom(
    name: 'EventControllerBase.priorityEvents',
    context: context,
  );

  @override
  ObservableList<Event>? get priorityEvents {
    _$priorityEventsAtom.reportRead();
    return super.priorityEvents;
  }

  @override
  set priorityEvents(ObservableList<Event>? value) {
    _$priorityEventsAtom.reportWrite(value, super.priorityEvents, () {
      super.priorityEvents = value;
    });
  }

  late final _$loadingAtom = Atom(
    name: 'EventControllerBase.loading',
    context: context,
  );

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

  late final _$currentDateAtom = Atom(
    name: 'EventControllerBase.currentDate',
    context: context,
  );

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

  late final _$currentMonthAtom = Atom(
    name: 'EventControllerBase.currentMonth',
    context: context,
  );

  @override
  String? get currentMonth {
    _$currentMonthAtom.reportRead();
    return super.currentMonth;
  }

  @override
  set currentMonth(String? value) {
    _$currentMonthAtom.reportWrite(value, super.currentMonth, () {
      super.currentMonth = value;
    });
  }

  late final _$fetchEventoAsyncAction = AsyncAction(
    'EventControllerBase.fetchEvento',
    context: context,
  );

  @override
  Future<void> fetchEvento(int codigoAluno, int mes, int ano, int userId) {
    return _$fetchEventoAsyncAction.run(
      () => super.fetchEvento(codigoAluno, mes, ano, userId),
    );
  }

  late final _$changeCurrentMonthAsyncAction = AsyncAction(
    'EventControllerBase.changeCurrentMonth',
    context: context,
  );

  @override
  Future<void> changeCurrentMonth(int month, int codigoEol, int userId) {
    return _$changeCurrentMonthAsyncAction.run(
      () => super.changeCurrentMonth(month, codigoEol, userId),
    );
  }

  late final _$EventControllerBaseActionController = ActionController(
    name: 'EventControllerBase',
    context: context,
  );

  @override
  void loadingCurrentMonth(dynamic month) {
    final _$actionInfo = _$EventControllerBaseActionController.startAction(
      name: 'EventControllerBase.loadingCurrentMonth',
    );
    try {
      return super.loadingCurrentMonth(month);
    } finally {
      _$EventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listPriorityEvents(dynamic eventsList) {
    final _$actionInfo = _$EventControllerBaseActionController.startAction(
      name: 'EventControllerBase.listPriorityEvents',
    );
    try {
      return super.listPriorityEvents(eventsList);
    } finally {
      _$EventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
event: ${event},
events: ${events},
eventsSortDate: ${eventsSortDate},
priorityEvents: ${priorityEvents},
loading: ${loading},
currentDate: ${currentDate},
currentMonth: ${currentMonth}
    ''';
  }
}
