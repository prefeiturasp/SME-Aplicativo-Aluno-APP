import 'package:sme_app_aluno/models/event/event.dart';

abstract class IEventRepository {
  Future<List<Event>> fetchEvent(int codigoAluno, int mes, int ano, int userId);
}
