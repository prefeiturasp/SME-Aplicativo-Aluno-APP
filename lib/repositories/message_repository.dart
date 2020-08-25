import 'dart:convert';
import 'package:sme_app_aluno/interfaces/message_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';

class MessageRepository implements IMessageRepository {
  final UserService _userService = UserService();

  @override
  Future<List<Message>> fetchMessages(int codigoEol, int userId) async {
    final User user = await _userService.find(userId);
    try {
      final response = await http.get("${Api.HOST}/Notificacao/$codigoEol",
          headers: {"Authorization": "Bearer ${user.token}"});

      if (response.statusCode == 200) {
        List<dynamic> messages = jsonDecode(response.body);
        var sortMessages = messages.map((i) => Message.fromJson(i)).toList();
        sortMessages
          ..sort((b, a) =>
              DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));
        return sortMessages;
      } else {
        print("[MessageRepository] Erro ao carregar lista de Mensagens " +
            response.statusCode.toString());
        return null;
      }
    } catch (e, stacktrace) {
      print("[MessageRepository] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<bool> readMessage(int notificacaoId, int usuarioId, int codigoAlunoEol,
      bool mensagemVisualia) async {
    final User user = await _userService.find(usuarioId);

    Map data = {
      "notificacaoId": notificacaoId,
      "usuarioId": usuarioId,
      "codigoAlunoEol": codigoAlunoEol != null ? codigoAlunoEol : 0,
      "mensagemVisualizada": mensagemVisualia
    };

    //encode Map to JSON
    var body = json.encode(data);

    try {
      final response = await http.post(
        "${Api.HOST}/UsuarioNotificacaoLeitura",
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("[MessageRepository] Erro ao atualizar mensagem " +
            response.statusCode.toString());
        return null;
      }
    } catch (error, stacktrace) {
      print("[MessageRepository] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }
}
