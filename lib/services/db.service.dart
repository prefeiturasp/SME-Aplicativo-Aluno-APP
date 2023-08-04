import 'package:path/path.dart';
import '../utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final int versionDB;

  DBHelper({this.versionDB = 1});

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_TABLE_MESSAGES_SCRIPT);
        await db.execute(CREATE_TABLE_GROUP_MESSAGES_SCRIPT);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await db.execute(CREATE_TABLE_MESSAGES_SCRIPT);
        await db.execute(CREATE_TABLE_GROUP_MESSAGES_SCRIPT);
      },
      version: versionDB,
    );
  }
}
