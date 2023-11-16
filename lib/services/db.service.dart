import 'package:path/path.dart';
import '../utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final int versionDB;

  DBHelper({this.versionDB = 1});

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseNAME),
      onCreate: (db, version) async {
        await db.execute(createTableMessagesScript);
        await db.execute(createTableGroupMessagesScript);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await db.execute(createTableMessagesScript);
        await db.execute(createTableGroupMessagesScript);
      },
      version: versionDB,
    );
  }
}
