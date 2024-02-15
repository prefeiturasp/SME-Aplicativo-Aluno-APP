import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

import '../models/message/group.dart';
import 'db.service.dart';
import '../utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class GroupMessageService {
  final dbHelper = DBHelper(versionDB: 2);

  Future create(Group model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(tbGroupMessage, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('Erro ao criar mensagem: $ex');
      GetIt.I.get<SentryClient>().captureException(ex);
      throw Exception(ex);
    }
  }

  Future<List<Group>> all() async {
    try {
      final Database db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await db.query(tbGroupMessage);
      final groups = List.generate(
        maps.length,
        (i) {
          return Group(
            id: maps[i]['id'],
            codigo: maps[i]['codigo'],
          );
        },
      );
      return groups;
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex.toString());
      GetIt.I.get<SentryClient>().captureException(ex);
      throw Exception(ex);
    }
  }

  Future delete(int id) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.delete(
        tbGroupMessage,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex);
      throw Exception(ex);
    }
  }
}
