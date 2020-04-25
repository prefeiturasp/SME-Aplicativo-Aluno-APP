import 'dart:convert';
import 'package:sme_app_aluno/interfaces/message_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/utils/api.dart';

class MessageRepository implements IMessageRepository {
  @override
  Future<List<Message>> fetchMessages(String token) async {
    try {
      final response = await http.get("${Api.HOST}/Notificacao",
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        List<dynamic> messages = jsonDecode(response.body);
        return messages.map((i) => Message.fromJson(i)).toList();
      } else {
        print("[MessageRepository] Erro ao carregar lista de Mensagens " +
            response.statusCode.toString());
        return null;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Mensagens " + stacktrace.toString());
      return null;
    }
  }
}
