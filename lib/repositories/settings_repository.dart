import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/settings_repository_interface.dart';
import 'package:sme_app_aluno/models/settings/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class SettingsRepository implements ISettingsRepository {
  final Storage _storage = Storage();
  @override
  Future<Data> changePassword(String password) async {
    String token = await _storage.readValueStorage("token");
    Map _data = {"senha": password};

    var body = json.encode(_data);

    try {
      final response = await http.put(
        "${Api.HOST}/Autenticacao/Senha/Alterar",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        _storage.removeKey('current_password');
        _storage.insertString('current_password', password);
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        return data;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      print("[AlterarSenha] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }
}
