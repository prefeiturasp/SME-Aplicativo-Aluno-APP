import 'dart:developer';

import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/services/db.service.dart';
import 'package:sme_app_aluno/utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class MessageService {
  final dbHelper = DBHelper();

  Future create(Message model) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.insert(TB_MESSAGE, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      log("--------------------------");
      log("DB LOCAL -> Mensagem criada com sucesso: ${model.toMap()}");
      log("--------------------------");
    } catch (ex) {
      log("Erro ao criar mensagem: $ex");
      throw Exception(ex);
    }
  }

  Future<List<Message>> all() async {
    final Database _db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await _db.query(TB_MESSAGE);
      var messages = List.generate(
        maps.length,
        (i) {
          return Message(
            id: maps[i]['id'],
            titulo: maps[i]['titulo'],
            mensagem: maps[i]['mensagem'],
            categoriaNotificacao: maps[i]['categoriaNotificacao'],
            criadoEm: maps[i]['criadoEm'],
            dataEnvio: maps[i]['dataEnvio'],
            mensagemVisualizada: maps[i]['mensagemVisualizada'] == 1 ? true : false,
            codigoEOL: maps[i]['codigoEOL'] ?? null,
          );
        },
      );
      log("--------------------------");
      log("DB LOCAL -> Lista de mensagens carregada: $messages}");
      log("--------------------------");
      return messages;
    } catch (ex) {
      log(ex.toString());
      throw Exception(ex);
    }
  }

  Future delete(int id) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.delete(
        TB_MESSAGE,
        where: "id = ?",
        whereArgs: [id],
      );
      log("DB LOCAL -> Usuário removido com sucesso: $id");
    } catch (ex) {
      log("<--------------------------");
      log("Erro ao deletar usuário: $ex");
      log("<--------------------------");
      throw Exception(ex);
    }
  }
}
