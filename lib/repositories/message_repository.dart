import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../interfaces/message_repository_interface.dart';
import '../models/message/message.dart';
import '../services/message.service.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class MessageRepository implements IMessageRepository {
  final MessageService _messageService = MessageService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<List<Message>> fetchNewMessages(int codigoEol) async {
    try {
      final List<Message> messagesDB = await _messageService.all();
      final messageRecent = messagesDB[0].criadoEm;
      final dateFormaet = messageRecent.replaceAll(':', '%3A');

      final url = Uri.parse('${AppConfigReader.getApiHost()}/Mensagens/$codigoEol/desde/$dateFormaet');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> messagesResponse = jsonDecode(response.body);
        final algo = messagesResponse.map((m) => Message.fromJson(m)).toList();
        for (var message in algo) {
          _messageService.create(message);
        }
        final List<Message> messagesDBAll = await _messageService.all();
        messagesDBAll.sort((b, a) => DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));
        return messagesDBAll.where((element) => element.codigoEOL == codigoEol).toList();
      } else {
        return messagesDB;
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<Message> getMessageById(int messageId, int userId) async {
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Mensagens/$messageId');
      final response = await http.get(url, headers: {'Authorization': 'Bearer ${usuarioStore.usuario.token}'});

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final message = Message.fromJson(decodeJson);
        return message;
      } else {
        return Message(
          id: 0,
          mensagem: '',
          titulo: '',
          dataEnvio: DateTime.now().toIso8601String(),
          criadoEm: DateTime.now().toIso8601String(),
          mensagemVisualizada: true,
          categoriaNotificacao: '',
          codigoEOL: 0,
        );
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<Message>> fetchMessages(int codigoEol, int userId) async {
    try {
      final List<Message> messagesDB = await _messageService.all();
      final List<Message> messagesDBForEOL = messagesDB.where((element) => element.codigoEOL == codigoEol).toList();
      if (messagesDBForEOL.isNotEmpty) {
        final response = await fetchNewMessages(codigoEol);
        return response;
      } else {
        final url = Uri.parse('${AppConfigReader.getApiHost()}/Notificacao/$codigoEol');
        final response = await http.get(url, headers: {'Authorization': 'Bearer ${usuarioStore.usuario.token}'});

        if (response.statusCode == 200) {
          final List<dynamic> messages = jsonDecode(response.body);
          final sortMessages = messages
              .map(
                (json) => Message(
                  id: json['id'],
                  mensagem: json['mensagem'],
                  titulo: json['titulo'],
                  dataEnvio: json['dataEnvio'],
                  criadoEm: json['criadoEm'],
                  alteradoEm: json['alteradoEm'],
                  mensagemVisualizada: json['mensagemVisualizada'],
                  categoriaNotificacao: json['categoriaNotificacao'],
                  codigoEOL: codigoEol,
                ),
              )
              .toList()
            ..sort((b, a) => DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));

          for (var message in sortMessages) {
            _messageService.create(message);
          }

          return sortMessages;
        } else {
          log('Status Code fetchMessages ${response.statusCode}');
          return List<Message>() = [];
        }
      }
    } catch (e) {
      log(e.toString());
      return throw Exception(e);
    }
  }

  @override
  Future<bool> readMessage(int notificacaoId, int usuarioId, int codigoAlunoEol, bool mensagemVisualia) async {
    final Map data = {
      'notificacaoId': notificacaoId,
      'usuarioId': usuarioId,
      'codigoAlunoEol': codigoAlunoEol,
      'mensagemVisualizada': mensagemVisualia
    };

    //encode Map to JSON
    final body = json.encode(data);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/UsuarioNotificacaoLeitura');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('[MessageRepository] Erro ao atualizar mensagem ${response.statusCode}');
        return throw Exception(response.reasonPhrase);
      }
    } catch (error, stacktrace) {
      log('[MessageRepository] Erro de requisição $stacktrace');
      return throw Exception(error);
    }
  }

  @override
  Future<bool> deleteMessage(int codigoEol, int idNotificacao, int userId) async {
    final List<Message> messagesDB = await _messageService.all();
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Mensagens/$idNotificacao/$codigoEol');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        await _messageService.delete(idNotificacao);

        for (var element in messagesDB) {
          _messageService.delete(element.id);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Erro ao tentar excluir mensagem $e');

      return false;
    }
  }
}
