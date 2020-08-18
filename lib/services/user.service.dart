import 'package:path/path.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), DATABASE_NAME),
        onCreate: (db, version) {
      return db.execute(CREATE_TABLE_SCRIPT);
    }, version: 1);
  }

  Future<List<User>> all() async {
    try {
      final Database _db = await _initDatabase();
      final List<Map<String, dynamic>> maps = await _db.query(TB_USER);
      var users = List.generate(
        maps.length,
        (i) {
          return User.fromJson(maps[i]);
        },
      );
      print("--------------------------");
      print("Lista de usuários carregada: $users}");
      print("--------------------------");
      return users;
    } catch (ex) {
      print(ex);
      return new List<User>();
    }
  }

  Future create(User model) async {
    final Database _db = await _initDatabase();
    try {
      await _db.insert(TB_USER, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("--------------------------");
      print("Usuário criado com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<User> find(int id) async {
    final Database _db = await _initDatabase();
    try {
      final List<Map<String, dynamic>> maps =
          await _db.query(TB_USER, where: "id = ?", whereArgs: [id]);
      User user = User.fromJson(maps[0]);
      print("--------------------------");
      print("Usuário encontrado com sucesso: ${user.toMap()}");
      print("--------------------------");
      return user;
    } catch (e) {
      return new User();
    }
  }

  Future update(User model) async {
    try {
      final Database _db = await _initDatabase();
      await _db.update(
        TB_USER,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
      print("--------------------------");
      print("Usuário atualizado com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future delete(int id) async {
    final Database _db = await _initDatabase();
    try {
      await _db.delete(
        TB_USER,
        where: "id = ?",
        whereArgs: [id],
      );
      print("Usuário removido com sucesso: $id");
    } catch (ex) {
      print(ex);
      return;
    }
  }
}
