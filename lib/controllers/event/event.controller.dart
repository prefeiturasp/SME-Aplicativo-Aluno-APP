import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/repositories/event_repository.dart';
part 'event.controller.g.dart';

class EventController = _EventControllerBase with _$EventController;

abstract class _EventControllerBase with Store {
  EventRepository _eventRepository;

  _EventControllerBase() {
    _eventRepository = EventRepository();
    loadingCurrentMonth(currentDate.month);
  }

  @observable
  Event event;

  @observable
  ObservableList<Event> events;

  @observable
  ObservableList<Event> eventsSortDate;

  @observable
  ObservableList<Event> priorityEvents;

  @observable
  bool loading = false;

  @observable
  DateTime currentDate = DateTime.now();

  @observable
  String currentMonth;

  @action
  loadingCurrentMonth(month) {
    switch (month) {
      case 1:
        currentMonth = "Janeiro";
        break;
      case 2:
        currentMonth = "Fevereiro";
        break;
      case 3:
        currentMonth = "Março";
        break;
      case 4:
        currentMonth = "Abril";
        break;
      case 5:
        currentMonth = "Maio";
        break;
      case 6:
        currentMonth = "Junho";
        break;
      case 7:
        currentMonth = "Julho";
        break;
      case 8:
        currentMonth = "Agosto";
        break;
      case 9:
        currentMonth = "Setembro";
        break;
      case 10:
        currentMonth = "Outubro";
        break;
      case 11:
        currentMonth = "Novembro";
        break;
      case 12:
        currentMonth = "Dezembro";
        break;
    }
  }

  @action
  fetchEvento(int codigoAluno, int mes, int ano, int userId) async {
    loading = true;
    events = ObservableList<Event>.of(await _eventRepository.fetchEvent(
      codigoAluno,
      mes,
      ano,
      userId,
    ));

    var auxList = events
      ..sort((a, b) =>
          DateTime.parse(a.dataInicio).compareTo(DateTime.parse(b.dataInicio)));

    eventsSortDate = ObservableList<Event>.of(auxList);

    if (events.isNotEmpty) {
      listPriorityEvents(events);
    }
    loading = false;
  }

  @action
  changeCurrentMonth(int month, int codigoEol, int userId) async {
    loadingCurrentMonth(month);
    await fetchEvento(codigoEol, month, currentDate.year, userId);
  }

  @action
  listPriorityEvents(eventsList) {
    var filterList = ObservableList<Event>.of([]);
    var sortList = ObservableList<Event>.of([]);
    var takeList = ObservableList<Event>.of([]);

    filterList = ObservableList<Event>.of(eventsList
        .where((i) => DateTime.parse(i.dataInicio).day >= currentDate.day)
        .toList());

    sortList = ObservableList<Event>.of(filterList
      ..sort((a, b) =>
          (a.tipoEvento.toString()).compareTo(b.tipoEvento.toString())));

    takeList = sortList.length > 4
        ? ObservableList<Event>.of(sortList.take(4).toList())
        : ObservableList<Event>.of(sortList);

    priorityEvents = takeList;
  }
}
