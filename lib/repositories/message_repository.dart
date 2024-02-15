import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

import '../interfaces/message_repository_interface.dart';
import '../models/message/message.dart';
import '../services/api.service.dart';
import '../services/message.service.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class MessageRepository implements IMessageRepository {
  final MessageService _messageService = MessageService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final api = GetIt.I.get<ApiService>();
  @override
  Future<List<Message>> fetchNewMessages(int codigoEol) async {
    try {
      final List<Message> messagesDB = await _messageService.all();
      final messageRecent = messagesDB[0].criadoEm;
      final dateFormaet = messageRecent.replaceAll(':', '%3A');

      final response = await api.dio.get('/Mensagens/$codigoEol/desde/$dateFormaet');
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          final messagem = Message.fromMap(response.data[i]);
          messagem.codigoEOL = codigoEol;
          _messageService.create(messagem);
        }
        final messagesDBAll = await _messageService.all();
        messagesDBAll.sort((b, a) => DateTime.parse(a.criadoEm).compareTo(DateTime.parse(b.criadoEm)));
        final lista = messagesDBAll.where((element) => element.codigoEOL == codigoEol).toList();
        return lista;
      }
      return messagesDB;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('fetchNewMessages $e');
      return [];
    }
  }

  Future<Message> getMessageById(int messageId, int userId) async {
    try {
      final response = await api.dio.get('/Mensagens/$messageId');
      if (response.statusCode == 200) {
        final message = Message.fromMap(response.data);
        return message;
      }
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
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('getMessageById $e');
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
        final response = await http.get(url, headers: {'Authorization': 'Bearer ${usuarioStore.usuario!.token}'});

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
          GetIt.I.get<SentryClient>().captureException('Status Code fetchMessages ${response.statusCode}');
          return List<Message>() = [];
        }
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('MessageRepository fetchMessages $e');
      return List<Message>() = [];
    }
  }

  @override
  Future<bool> readMessage(int notificacaoId, int usuarioId, int codigoAlunoEol, bool mensagemVisualia) async {
    final Map data = {
      'notificacaoId': notificacaoId,
      'usuarioId': usuarioId,
      'codigoAlunoEol': codigoAlunoEol,
      'mensagemVisualizada': mensagemVisualia,
    };

    //encode Map to JSON
    final body = json.encode(data);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/UsuarioNotificacaoLeitura');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final retorno = Message.fromMap(jsonDecode(response.body));
        return retorno.mensagemVisualizada;
      } else {
        log('[MessageRepository] Erro ao atualizar mensagem ${response.statusCode}');
        return false;
      }
    } catch (error, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('[MessageRepository] Erro de requisição $error $stacktrace');
      return false;
    }
  }

  @override
  Future<bool> deleteMessage(int codigoEol, int idNotificacao, int userId) async {
    final List<Message> messagesDB = await _messageService.all();
    try {
      final response = await api.dio.delete('/Mensagens/$idNotificacao/$codigoEol');
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
      GetIt.I.get<SentryClient>().captureException('Erro ao tentar excluir mensagem $e');

      return false;
    }
  }
}
