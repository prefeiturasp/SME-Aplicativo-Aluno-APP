import 'package:sme_app_aluno/models/message/group.dart';
import 'package:sme_app_aluno/services/db.service.dart';
import 'package:sme_app_aluno/utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class GroupMessageService {
  final dbHelper = DBHelper(versionDB: 2);

  Future create(Group model) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.insert(TB_GROUP_MESSAGE, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("--------------------------");
      print("Grupo de menssagem criado com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print("Erro ao criar mensagem: $ex");
      return;
    }
  }

  Future<List<Group>> all() async {
    try {
      final Database _db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await _db.query(TB_GROUP_MESSAGE);
      var groups = List.generate(
        maps.length,
        (i) {
          return Group(
            id: maps[i]['id'],
            codigo: maps[i]['codigo'],
          );
        },
      );
      print("--------------------------");
      print("Lista de grupos de mensagens: ${groups.cast()}");
      print("--------------------------");
      return groups;
    } catch (ex) {
      print(ex);
      return new List<Group>();
    }
  }

  Future delete(int id) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.delete(
        TB_GROUP_MESSAGE,
        where: "id = ?",
        whereArgs: [id],
      );
      print("Grupo de Mensagem removida com sucesso: $id");
    } catch (ex) {
      print("<--------------------------");
      print("Erro ao deletar usuário: $ex");
      print("<--------------------------");
      return;
    }
  }
}
