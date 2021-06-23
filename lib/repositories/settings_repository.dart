import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/settings_repository_interface.dart';
import 'package:sme_app_aluno/models/settings/data.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class SettingsRepository implements ISettingsRepository {
  final UserService _userService = UserService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<Data> changePassword(
      String password, String oldPassword, int userId) async {
    Map _data = {
      "novaSenha": password,
      "senhaAntiga": oldPassword,
    };

    var body = json.encode(_data);

    try {
      final response = await http.put(
        "${AppConfigReader.getApiHost()}/Autenticacao/Senha/Alterar",
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        await _userService.update(User(
          id: usuarioStore.usuario.id,
          nome: usuarioStore.usuario.nome,
          cpf: usuarioStore.usuario.cpf,
          email: usuarioStore.usuario.email,
          celular: usuarioStore.usuario.celular,
          token: data.token,
          primeiroAcesso: usuarioStore.usuario?.primeiroAcesso,
          atualizarDadosCadastrais:
              usuarioStore.usuario.atualizarDadosCadastrais,
        ));
        return data;
      } else if (response.statusCode == 408) {
        return Data(
            ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
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
