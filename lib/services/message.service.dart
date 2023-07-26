import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../models/message/message.dart';
import '../utils/db/db_settings.dart';
import 'db.service.dart';

class MessageService {
  final dbHelper = DBHelper();

  Future create(Message model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(TB_MESSAGE, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      log('Erro ao criar mensagem: $ex');
      throw Exception(ex);
    }
  }

  Future<List<Message>> all() async {
    final Database db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query(TB_MESSAGE);
      final messages = List.generate(
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
            codigoEOL: maps[i]['codigoEOL'],
          );
        },
      );
      return messages;
    } catch (ex) {
      log(ex.toString());
      throw Exception(ex);
    }
  }

  Future delete(int id) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.delete(
        TB_MESSAGE,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      log('Erro ao deletar usuário: $ex');
      throw Exception(ex);
    }
  }
}
