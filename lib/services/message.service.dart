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
      print("Mensagem criada com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print("Erro ao criar mensagem: $ex");
      return;
    }
  }

  Future<List<Message>> all() async {
    try {
      final Database _db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await _db.query(TB_USER);
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
      print("Lista de mensagens carregada: $messages}");
      print("--------------------------");
      return messages;
    } catch (ex) {
      print(ex);
      return new List<Message>();
    }
  }
}
