import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/settings_repository_interface.dart';
import 'package:sme_app_aluno/models/settings/data.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/global_config.dart';

class SettingsRepository implements ISettingsRepository {
  final UserService _userService = UserService();

  @override
  Future<Data> changePassword(
      String password, String oldPassword, int userId) async {
    final User user = await _userService.find(userId);

    Map _data = {
      "novaSenha": password,
      "senhaAntiga": oldPassword,
    };

    var body = json.encode(_data);

    try {
      final response = await http.put(
        "${Api.HOST}/Autenticacao/Senha/Alterar",
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        await _userService.update(User(
          id: user.id,
          nome: user.nome,
          cpf: user.cpf,
          email: user.email,
          celular: user.celular,
          token: data.token,
          primeiroAcesso: user.primeiroAcesso,
          informarCelularEmail: user.informarCelularEmail,
        ));
        return data;
      } else if (response.statusCode == 408) {
        return Data(ok: false, erros: [GlobalConfig.ERROR_MESSAGE_TIME_OUT]);
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
