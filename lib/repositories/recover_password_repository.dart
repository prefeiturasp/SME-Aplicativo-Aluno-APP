import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sme_app_aluno/interfaces/recover_password_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/recover_password/data.dart';
import 'package:sme_app_aluno/models/recover_password/data_user.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  final Storage _storage = Storage();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
      print("[RecoverPassword] sendToken - Erro de requisição " +
          stacktrace.toString());
      return null;
    }
  }

  @override
  Future<Data> validateToken(String token) async {
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
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        return data;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      print("[RecoverPassword] validateToken - Erro de requisição " +
          stacktrace.toString());
      return null;
    }
  }

  @override
  Future<DataUser> redefinePassword(String password, String token) async {
    String idDevice = await _firebaseMessaging.getToken();
    Map _data = {"token": token, "senha": password, "dispositivoId": idDevice};
    var body = json.encode(_data);

    try {
      final response = await http.put(
        "${Api.HOST}/Autenticacao/Senha/Redefinir",
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = DataUser.fromJson(decodeJson);

        addCurrentUserToStorage(
            idDevice,
            user.data.nome,
            user.data.cpf,
            user.data.email ?? "",
            user.data.token,
            user.data.primeiroAcesso ? "" : password,
            user.data.id,
            user.data.celular ?? "",
            user.data.primeiroAcesso,
            user.data.informarCelularEmail);
        return user;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = DataUser.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      print("[RecoverPassword] redefinePassword - Erro de requisição " +
          stacktrace.toString());
      return null;
    }
  }

  addCurrentUserToStorage(
    String dispositivoId,
    String name,
    String cpf,
    String email,
    String token,
    String password,
    int userId,
    String celular,
    bool primeiroAcesso,
    bool informarCelularEmail,
  ) async {
    _storage.insertString('current_name', name);
    _storage.insertString('current_cpf', cpf);
    _storage.insertString('current_email', email);
    _storage.insertString('token', token);
    _storage.insertString('current_password', password);
    _storage.insertString('dispositivo_id', dispositivoId);
    _storage.insertInt('current_user_id', userId);
    _storage.insertString('current_celular', celular);
    _storage.insertBool('current_primeiro_acesso', primeiroAcesso);
    _storage.insertBool('current_informar_celular_email', informarCelularEmail);
  }
}
