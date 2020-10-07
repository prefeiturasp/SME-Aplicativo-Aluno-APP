import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/repositories/event_repository.dart';
part 'event.controller.g.dart';

class EventController = _EventControllerBase with _$EventController;

abstract class _EventControllerBase with Store {
  EventRepository _eventRepository;

  _EventControllerBase() {
    _eventRepository = EventRepository();
  }

  @observable
  Event event;

  @observable
  ObservableList<Event> events;

  @observable
  bool loading = false;

  @action
  fetchEvento(int codigoAluno, int mes, int ano, int userId) async {
    loading = true;
    events = ObservableList<Event>.of(await _eventRepository.fetchEvent(
      codigoAluno,
      mes,
      ano,
      userId,
    ));
    loading = false;
  }
}
