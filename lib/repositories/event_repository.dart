import 'dart:convert';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/event_repository_interface.dart';
import 'package:sme_app_aluno/models/event/event.dart' as EventModel;
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class EventRepository extends IEventRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<List<EventModel.Event>> fetchEvent(int codigoAluno, int mes, int ano, int userId) async {
    try {
      var url = Uri.https(
          "${AppConfigReader.getApiHost()}/Evento/AlunoLogado/${ano.toInt()}/${mes.toInt()}/${codigoAluno.toInt()}");
      var response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${usuarioStore.usuario.token}", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        List<dynamic> eventResponse = jsonDecode(response.body);
        var eventos = eventResponse.map((m) => EventModel.Event.fromJson(m)).toList();
        return eventos;
      } else {
        log('Erro ao obter dados');
        return [];
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }
}
