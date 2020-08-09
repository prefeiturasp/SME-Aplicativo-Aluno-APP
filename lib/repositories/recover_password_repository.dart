import 'dart:convert';

import 'package:sme_app_aluno/interfaces/recover_password_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/recover_password/data.dart';
import 'package:sme_app_aluno/utils/api.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  @override
  Future<Data> sendToken(String cpf) async {
    var _cpfUnformat = cpf.replaceAll(RegExp(r'[^\w\s]+'), '');
    Map _data = {
      "cpf": _cpfUnformat,
    };
    var body = json.encode(_data);

    try {
      final response = await http.put(
        "${Api.HOST}/Autenticacao/Senha/Token",
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
      print("[fetchFirstAccess] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<String> validateToken(String token) async {
    Map _data = {
      "token": token,
    };
    var body = json.encode(_data);
    try {
      final response = await http.put(
        "${Api.HOST}/Autenticacao/Senha/Token/Validar",
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
