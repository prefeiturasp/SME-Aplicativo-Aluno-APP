import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/event_repository_interface.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';

class EventRepository extends IEventRepository {
  final UserService _userService = UserService();

  @override
  Future<List<Event>> fetchEvent(
      int codigoAluno, int mes, int ano, int userId) async {
    User user = await _userService.find(userId);

    try {
      var response = await http.get(
        "${Api.HOST}/Evento/AlunoLogado/${ano.toInt()}/${mes.toInt()}/${codigoAluno.toInt()}",
        headers: {
          "Authorization": "Bearer ${user.token}",
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
