import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/interfaces/message_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/message.service.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class MessageRepository implements IMessageRepository {
  final UserService _userService = UserService();
  final MessageService _messageService = MessageService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<List<Message>> fetchNewMessages(int codigoEol) async {
    try {
      List<Message> messagesDB = await _messageService.all();
      var messageRecent = messagesDB[0].criadoEm;
      var dateFormaet = messageRecent.replaceAll(':', '%3A');

      final response = await http.get(
          "${AppConfigReader.getApiHost()}/Mensagens/$codigoEol/desde/$dateFormaet",
          headers: {
            "Authorization": "Bearer ${usuarioStore.usuario.token}",
            "Content-Type": "application/json",
          });

      if (response.statusCode == 200) {
        List<dynamic> messagesResponse = jsonDecode(response.body);
        var algo = messagesResponse.map((m) => Message.fromJson(m)).toList();
        algo.forEach((message) {
          _messageService.create(message);
        });
        List<Message> messagesDBAll = await _messageService.all();
        messagesDBAll.sort((b, a) =>
            DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));
        return messagesDBAll
            .where((element) => element.codigoEOL == codigoEol)
            .toList();
      } else {
        return messagesDB;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Message> getMessageById(int messageId, int userId) async {
    try {
      final response = await http.get(
          "${AppConfigReader.getApiHost()}/Mensagens/$messageId",
          headers: {"Authorization": "Bearer ${usuarioStore.usuario.token}"});

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final message = Message.fromJson(decodeJson);
        return message;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<List<Message>> fetchMessages(int codigoEol, int userId) async {
    try {
      List<Message> messagesDB = await _messageService.all();
      List<Message> messagesDBForEOL = messagesDB
          .where((element) => element.codigoEOL == codigoEol)
          .toList();
      if (messagesDBForEOL.length > 0) {
        var response = await fetchNewMessages(codigoEol);
        return response;
      } else {
        final response = await http.get(
            "${AppConfigReader.getApiHost()}/Notificacao/$codigoEol",
            headers: {"Authorization": "Bearer ${usuarioStore.usuario.token}"});

        if (response.statusCode == 200) {
          List<dynamic> messages = jsonDecode(response.body);
          var sortMessages = messages
              .map((json) => Message(
                    id: json['id'],
                    mensagem: json['mensagem'],
                    titulo: json['titulo'],
                    dataEnvio: json['dataEnvio'],
                    criadoEm: json['criadoEm'],
                    alteradoEm: json['alteradoEm'],
                    mensagemVisualizada: json['mensagemVisualizada'],
                    categoriaNotificacao: json['categoriaNotificacao'],
                    codigoEOL: codigoEol,
                  ))
              .toList()
                ..sort((b, a) => DateTime.parse(a.criadoEm)
                    .compareTo(DateTime.parse(b.criadoEm)));

          sortMessages.forEach((message) {
            _messageService.create(message);
          });

          return sortMessages;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool> readMessage(int notificacaoId, int usuarioId, int codigoAlunoEol,
      bool mensagemVisualia) async {
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
        "${AppConfigReader.getApiHost()}/UsuarioNotificacaoLeitura",
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
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

  @override
  Future<bool> deleteMessage(
      int codigoEol, int idNotificacao, int userId) async {
    List<Message> messagesDB = await _messageService.all();
    try {
      final response = await http.delete(
          "${AppConfigReader.getApiHost()}/Mensagens/$idNotificacao/$codigoEol",
          headers: {
            "Authorization": "Bearer ${usuarioStore.usuario.token}",
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        await _messageService.delete(idNotificacao);

        messagesDB.forEach((element) {
          _messageService.delete(element.id);
        });

        return null;
      } else {
        return null;
      }
    } catch (e) {
      print("Erro ao tentar excluir mensagem $e");
      return null;
    }
  }
}
