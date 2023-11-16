import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../dtos/validacao_erro_dto.dart';
import '../interfaces/settings_repository_interface.dart';
import '../models/settings/data.dart';
import '../models/user/user.dart' as user_model;
import '../services/user.service.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class SettingsRepository implements ISettingsRepository {
  final UserService _userService = UserService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<Data> changePassword(String password, String oldPassword, int userId) async {
    final Map data0 = {
      'novaSenha': password,
      'senhaAntiga': oldPassword,
    };

    final body = json.encode(data0);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Alterar');
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final data = Data.fromJson(decodeJson);
        await _userService.update(
          user_model.User(
            id: usuarioStore.usuario!.id,
            nome: usuarioStore.usuario!.nome,
            cpf: usuarioStore.usuario!.cpf,
            email: usuarioStore.usuario!.email,
            celular: usuarioStore.usuario!.celular,
            token: data.token,
            primeiroAcesso: usuarioStore.usuario!.primeiroAcesso,
            atualizarDadosCadastrais: usuarioStore.usuario!.atualizarDadosCadastrais,
            nomeMae: usuarioStore.usuario!.nomeMae,
            dataNascimento: usuarioStore.usuario!.dataNascimento,
            senha: usuarioStore.usuario!.senha,
          ),
        );
        return data;
      } else if (response.statusCode == 408) {
        return Data(
          ok: false,
          erros: [AppConfigReader.getErrorMessageTimeOut()],
          token: '',
          validacaoErros: ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []),
        );
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log('[AlterarSenha] Erro de requisição $stacktrace');
      throw Exception(error);
    }
  }
}
