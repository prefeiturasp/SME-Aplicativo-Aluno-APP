import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/repositories/event_repository.dart';
part 'event.controller.g.dart';

class EventController = EventControllerBase with _$EventController;

abstract class EventControllerBase with Store {
  late final EventRepository _eventRepository;

  EventControllerBase() {
    this._eventRepository = EventRepository();
    loadingCurrentMonth(currentDate.month);
  }

  @observable
  late Event event;

  @observable
  late ObservableList<Event> events;

  @observable
  late ObservableList<Event> eventsSortDate;

  @observable
  late ObservableList<Event> priorityEvents;

  @observable
  bool loading = false;

  @observable
  DateTime currentDate = DateTime.now();

  @observable
  late String currentMonth;

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

    var auxList = events..sort((a, b) => DateTime.parse(a.dataInicio).compareTo(DateTime.parse(b.dataInicio)));

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
    var provaList = ObservableList<Event>.of([]);
    var othersList = ObservableList<Event>.of([]);
    var auxList = ObservableList<Event>.of([]);
    var completeList = ObservableList<Event>.of([]);
    var takeAuxReversedList = ObservableList<Event>.of([]);

    var reversedList = eventsList.reversed.take(4).toList();
    var reversedListOrganized = reversedList
      ..sort((a, b) => DateTime.parse(a.dataInicio).compareTo(DateTime.parse(b.dataInicio)));

    filterList =
        ObservableList<Event>.of(eventsList.where((i) => DateTime.parse(i.dataInicio).day >= currentDate.day).toList());

    provaList = ObservableList<Event>.of(filterList.where((i) => i.tipoEvento == 0));

    othersList = ObservableList<Event>.of(filterList.where((i) => i.tipoEvento != 0));

    sortList = ObservableList<Event>.of(provaList + othersList);

    auxList =
        ObservableList<Event>.of(eventsList.where((i) => DateTime.parse(i.dataInicio).day < currentDate.day).toList());

    var takeAuxReversed = sortList.length == 3
        ? auxList.reversed.take(1).toList()
        : sortList.length == 2
            ? auxList.reversed.take(2).toList()
            : sortList.length == 1
                ? auxList.reversed.take(3).toList()
                : auxList.reversed.take(0).toList();

    takeAuxReversedList = ObservableList<Event>.of(othersList + takeAuxReversed);

    var auxListOrganized = takeAuxReversedList
      ..sort((a, b) => DateTime.parse(a.dataInicio).compareTo(DateTime.parse(b.dataInicio)));

    completeList = ObservableList<Event>.of(provaList + auxListOrganized);

    takeList = sortList.length > 4
        ? ObservableList<Event>.of(sortList.take(4).toList())
        : sortList.length == 4
            ? ObservableList<Event>.of(sortList)
            : sortList.length > 0
                ? ObservableList<Event>.of(completeList.take(4).toList())
                : ObservableList<Event>.of(reversedListOrganized);

    priorityEvents = takeList;
  }
}
