import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/first_access_repository_interface.dart';
import 'package:sme_app_aluno/models/first_access/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class FirstAccessRepository implements IFirstAccessRepository {
  final Storage storage = Storage();
  @override
  Future<Data> changeNewPassword(int id, String password) async {
    String token = await storage.readValueStorage("token");
    int _id = await storage.readValueIntStorage("current_user_id");
    Map _data = {"id": _id, "novaSenha": password};

    var body = json.encode(_data);
    try {
      final response = await http.post(
        "${Api.HOST}/Autenticacao/PrimeiroAcesso",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        storage.insertBool('current_primeiro_acesso', false);
        return data;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      print("[fetchFirstAccess] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }

  @override
  Future<Data> changeEmailAndPhone(String email, String phone) async {
    String token = await storage.readValueStorage("token");
    int _id = await storage.readValueIntStorage("current_user_id");
    Map _data = {
      "id": _id,
      "email": email ?? "",
      "celular":
          phone != null ? phone.replaceAll(new RegExp(r'[^\w\s]+'), '') : ""
    };
    var body = json.encode(_data);
    try {
      final response = await http.post(
        "${Api.HOST}/Autenticacao/AlterarEmailCelular",
        headers: {
          "Authorization": "Bearer $token",
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
    } catch (error, stacktrace) {
      print("[changePhone] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }
}
