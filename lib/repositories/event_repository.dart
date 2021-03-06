import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/event_repository_interface.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class EventRepository extends IEventRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<List<Event>> fetchEvent(
      int codigoAluno, int mes, int ano, int userId) async {
    try {
      var response = await http.get(
        "${AppConfigReader.getApiHost()}/Evento/AlunoLogado/${ano.toInt()}/${mes.toInt()}/${codigoAluno.toInt()}",
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> eventResponse = jsonDecode(response.body);
        var eventos = eventResponse.map((m) => Event.fromJson(m)).toList();
        return eventos;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
