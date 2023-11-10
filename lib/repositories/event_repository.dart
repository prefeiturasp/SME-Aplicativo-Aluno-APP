import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

import '../interfaces/event_repository_interface.dart';
import '../models/event/event.dart' as eventmodel;
import '../services/api.service.dart';
import '../stores/index.dart';

class EventRepository extends IEventRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final api = GetIt.I.get<ApiService>();

  @override
  Future<List<eventmodel.Event>> fetchEvent(int codigoAluno, int mes, int ano, int userId) async {
    try {
      final List<eventmodel.Event> retorno = [];
      final response = await api.dio.get('/Evento/AlunoLogado/${ano.toInt()}/${mes.toInt()}/${codigoAluno.toInt()}');
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          retorno.add(eventmodel.Event.fromMap(response.data[i]));
        }
        return retorno;
      } else {
        log('Erro ao obter eventos ${response.statusCode}');
        return retorno;
      }
    } catch (e) {
      log('Erro ao obter eventos $e');
      GetIt.I.get<SentryClient>().captureException(e);
      return [];
    }
  }
}
