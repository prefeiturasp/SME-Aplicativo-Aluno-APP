import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/services/db.service.dart';
import 'package:sme_app_aluno/utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class MessageService {
  final dbHelper = DBHelper();

  Future create(Message model) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.insert(TB_MESSAGE, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("--------------------------");
      print("DB LOCAL -> Mensagem criada com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print("Erro ao criar mensagem: $ex");
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      return;
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
            mensagemVisualizada:
                maps[i]['mensagemVisualizada'] == 1 ? true : false,
            codigoEOL: maps[i]['codigoEOL'] ?? null,
          );
        },
      );
      print("--------------------------");
      print("DB LOCAL -> Lista de mensagens carregada: $messages}");
      print("--------------------------");
      return messages;
    } catch (ex) {
      print(ex);
      return new List<Message>();
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
      print("DB LOCAL -> Usuário removido com sucesso: $id");
    } catch (ex) {
      print("<--------------------------");
      print("Erro ao deletar usuário: $ex");
      print("<--------------------------");
      return;
    }
  }
}
