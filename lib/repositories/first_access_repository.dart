import 'dart:convert';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/first_access_repository_interface.dart';
import 'package:sme_app_aluno/models/change_email_and_phone/data_change_email_and_phone.dart';
import 'package:sme_app_aluno/models/first_access/data.dart';
import 'package:sme_app_aluno/models/user/user.dart' as UserModel;
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class FirstAccessRepository implements IFirstAccessRepository {
  final UserService _userService = UserService();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<Data> changeNewPassword(int id, String password) async {
    Map _data = {
      "id": usuarioStore.usuario.id,
      "novaSenha": password,
    };

    var body = json.encode(_data);
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/Autenticacao/PrimeiroAcesso");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      var decodeJson = jsonDecode(response.body);
      var data = Data.fromJson(decodeJson);
      if (response.statusCode == 200) {
        await usuarioStore.atualizaPrimeiroAcesso(false);

        await _userService.update(UserModel.User(
          id: usuarioStore.usuario.id,
          nome: usuarioStore.usuario.nome,
          cpf: usuarioStore.usuario.cpf,
          email: usuarioStore.usuario.email,
          celular: usuarioStore.usuario.celular,
          token: usuarioStore.usuario.token,
          primeiroAcesso: false,
          atualizarDadosCadastrais: true,
        ));

        return data;
      } else if (response.statusCode == 408) {
        return Data(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log("[fetchFirstAccess] Erro de requisição " + stacktrace.toString());
      return Data(ok: false, erros: [error.toString()]);
    }
  }

  @override
  Future<DataChangeEmailAndPhone> changeEmailAndPhone(
      String email, String phone, int userId, bool changePassword) async {
    Map _data = {"id": userId, "email": email ?? "", "celular": phone ?? "", "alterarSenha": changePassword};
    var body = json.encode(_data);
    try {
      final url = Uri.https("${AppConfigReader.getApiHost()}/Autenticacao/AlterarEmailCelular");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = DataChangeEmailAndPhone.fromJson(decodeJson);
        await _userService.update(UserModel.User(
            id: userId,
            nome: usuarioStore.usuario.nome,
            cpf: usuarioStore.usuario.cpf,
            email: email,
            celular: phone,
            token: data.token,
            primeiroAcesso: false,
            atualizarDadosCadastrais: false));
        return data;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = DataChangeEmailAndPhone.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log("[changeEmailAndPhone] Erro de requisição " + stacktrace.toString());
      return DataChangeEmailAndPhone();
    }
  }
}
