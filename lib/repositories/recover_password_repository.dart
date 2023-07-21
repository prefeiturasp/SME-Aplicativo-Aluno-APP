import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/recover_password_interface.dart';
import 'package:sme_app_aluno/models/recover_password/data.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

import '../dtos/validacao_erro_dto.dart';
import '../models/recover_password/data_user.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final UserService _userService = UserService();

  @override
  Future<Data> sendToken(String cpf) async {
    var _cpfUnformat = cpf.replaceAll(RegExp(r'[^\w\s]+'), '');
    Map _data = {
      "cpf": _cpfUnformat,
    };
    var body = json.encode(_data);

    try {
      var url = Uri.parse("${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token");
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        return data;
      } else if (response.statusCode == 408) {
        return Data(
            ok: false,
            erros: [AppConfigReader.getErrorMessageTimeOut()],
            validacaoErros: ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []),
            email: '');
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log("[RecoverPassword] sendToken - Erro de requisição " + stacktrace.toString());
      throw Exception(e);
    }
  }

  @override
  Future<Data> validateToken(String token) async {
    Map _data = {
      "token": token,
    };
    var body = json.encode(_data);
    try {
      var url = Uri.parse("${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token/Validar");
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        return data;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log("[RecoverPassword] validateToken - Erro de requisição " + stacktrace.toString());
      throw Exception(e);
    }
  }

  @override
  Future<DataUser> redefinePassword(String password, String token) async {
    String? idDevice = await _firebaseMessaging.getToken();
    Map _data = {"token": token, "senha": password, "dispositivoId": idDevice};
    var body = json.encode(_data);

    try {
      var url = Uri.parse("${AppConfigReader.getApiHost()}/Autenticacao/Senha/Redefinir");
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = DataUser.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          _userService.create(user.data);
        }
        return user;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = DataUser.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log("[RecoverPassword] redefinePassword - Erro de requisição " + stacktrace.toString());
      throw Exception(e);
    }
  }
}
