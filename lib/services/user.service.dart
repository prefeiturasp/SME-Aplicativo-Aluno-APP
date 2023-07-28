import 'dart:developer';

import '../models/message/message.dart';
import '../models/user/user.dart' as UserModel;
import 'db.service.dart';
import '../utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  final dbHelper = DBHelper();

  Future<List<UserModel.User>> all() async {
    try {
      final Database db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TB_USER);
      final users = List.generate(
        maps.length,
        (i) {
          return UserModel.User(
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
      log('--------------------------');
      log('Lista de usuários carregada: $users}');
      log('--------------------------');
      return users;
    } catch (ex) {
      log(ex.toString());

      throw Exception(ex);
    }
  }

  Future create(UserModel.User model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(TB_USER, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      log('--------------------------');
      log('Usuário criado com sucesso: ${model.toMap()}');
      log('--------------------------');
    } catch (ex) {
      log('Erro ao criar usuário: $ex');
      throw Exception(ex);
    }
  }

  Future<UserModel.User> find(int id) async {
    final Database db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query(TB_USER, where: 'id = ?', whereArgs: [id]);
      final UserModel.User user = UserModel.User(
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
      log('--------------------------');
      log('Usuário encontrado com sucesso: ${user.toMap()}');
      log('--------------------------');
      return user;
    } catch (ex) {
      log('<--------------------------');
      log('Erro ao encontrar usuário: $ex');
      log('<--------------------------');
      throw Exception(ex);
    }
  }

  Future update(UserModel.User model) async {
    try {
      final Database db = await dbHelper.initDatabase();
      await db.update(
        TB_USER,
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );
      log('--------------------------');
      log('Usuário atualizado com sucesso: ${model.toMap()}');
      log('--------------------------');
    } catch (ex) {
      log('<--------------------------');
      log('Erro ao atualizar usuário: $ex');
      log('<--------------------------');
    }
  }

  Future delete(int id) async {
    final Database db = await dbHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TB_USER, where: 'id = ?', whereArgs: [id]);
    try {
      if (maps.isNotEmpty) {
        await db.delete(
          TB_USER,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
      log('Usuário removido com sucesso: $id');
    } catch (ex) {
      log('<--------------------------');
      log('Erro ao deletar usuário: $ex');
      log('<--------------------------');
    }
  }

  Future createMessage(Message model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(TB_MESSAGE, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      log('--------------------------');
      log('Mensagem criada com sucesso: ${model.toMap()}');
      log('--------------------------');
    } catch (ex) {
      log('Erro ao criar mensagem: $ex');
      throw Exception(ex);
    }
  }
}
