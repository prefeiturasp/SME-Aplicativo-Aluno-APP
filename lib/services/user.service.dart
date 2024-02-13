import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

import '../models/message/message.dart';
import '../models/user/user.dart' as user_model;
import 'db.service.dart';
import '../utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  final dbHelper = DBHelper();

  Future<List<user_model.User>> all() async {
    try {
      final Database db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await db.query(tbUSER);
      final users = List.generate(
        maps.length,
        (i) {
          return user_model.User(
            id: maps[i]['id'],
            nome: maps[i]['nome'],
            cpf: maps[i]['cpf'],
            email: maps[i]['email'],
            token: maps[i]['token'],
            nomeMae: maps[i]['nomeMae'],
            dataNascimento: maps[i]['dataNascimento'],
            senha: maps[i]['senha'],
            primeiroAcesso: maps[i]['primeiroAcesso'] == 1 ? true : false,
            atualizarDadosCadastrais: maps[i]['atualizarDadosCadastrais'] == 1 ? true : false,
            celular: maps[i]['celular'],
          );
        },
      );
      return users;
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex.toString());

      throw Exception(ex);
    }
  }

  Future create(user_model.User model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(tbUSER, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('Erro ao criar usuário: $ex');
      throw Exception(ex);
    }
  }

  Future<user_model.User> find(int id) async {
    final Database db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query(tbUSER, where: 'id = ?', whereArgs: [id]);
      final user_model.User user = user_model.User(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        cpf: maps[0]['cpf'],
        email: maps[0]['email'],
        token: maps[0]['token'],
        nomeMae: maps[0]['nomeMae'],
        dataNascimento: maps[0]['dataNascimento'],
        senha: maps[0]['senha'],
        primeiroAcesso: maps[0]['primeiroAcesso'] == 1 ? true : false,
        atualizarDadosCadastrais: maps[0]['atualizarDadosCadastrais'] == 1 ? true : false,
        celular: maps[0]['celular'],
      );
      return user;
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex);
      throw Exception(ex);
    }
  }

  Future update(user_model.User model) async {
    try {
      final Database db = await dbHelper.initDatabase();
      await db.update(
        tbUSER,
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex);
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await dbHelper.initDatabase();
      await db.rawQuery('delete from user where id =$id');
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(ex);
    }
  }

  Future createMessage(Message model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(tbMESSAGE, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('Erro ao criar mensagem: $ex');
      throw Exception(ex);
    }
  }
}
