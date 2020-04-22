import 'dart:convert';
import 'package:sme_app_aluno/interfaces/message_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/utils/api.dart';

class MessageRepository implements IMessageRepository {
  @override
  Future<List<Message>> fetchMessages(String token) async {
    try {
      final response = await http.get(
        "${Api.HOST}/Notificacao",
        headers: {"Authorization": "Bearer $token"}
      );

      return response.statusCode == 200
        ? _handleSuccess(response)
        : _handleError(response);
    } catch (e, stacktrace) {
      print("[ DEBUG ] MessageRepository._handleSuccess: Erro ao carregar lista de Mensagens ${stacktrace.toString()}");
      return null;
    }
  }

  _handleSuccess(response) {
    List<dynamic> json = jsonDecode(response.body);
    return json.map((i) => Message.fromJson(i)).toList();
  }

  _handleError(response) {
    print("[ DEBUG ] MessageRepository._handleError: Erro ao carregar lista de Mensagens ${jsonEncode(response)}");
    return null;
  }
}
