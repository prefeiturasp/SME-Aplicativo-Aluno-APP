import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../dtos/validacao_erro_dto.dart';
import '../interfaces/recover_password_interface.dart';
import '../models/recover_password/data.dart';
import '../models/recover_password/data_user.dart';
import '../services/user.service.dart';
import '../utils/app_config_reader.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final UserService _userService = UserService();

  @override
  Future<Data> sendToken(String cpf) async {
    final cpfUnformat = cpf.replaceAll(RegExp(r'[^\w\s]+'), '');
    final Map data0 = {
      'cpf': cpfUnformat,
    };
    final body = json.encode(data0);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final data = Data.fromJson(decodeJson);
        return data.email;
      } else if (response.statusCode == 408) {
        return Data(
          ok: false,
          erros: [AppConfigReader.getErrorMessageTimeOut()],
          validacaoErros: ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []),
          email: '',
        );
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log("[RecoverPassword] sendToken - Erro de requisição $stacktrace");
      throw Exception(e);
    }
  }

  @override
  Future<Data> validateToken(String token) async {
    final Map data0 = {
      'token': token,
    };
    final body = json.encode(data0);
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token/Validar');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final data = Data.fromJson(decodeJson);
        return data;
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log('[RecoverPassword] validateToken - Erro de requisição ' + stacktrace.toString());
      throw Exception(e);
    }
  }

  @override
  Future<DataUser> redefinePassword(String password, String token) async {
    String? idDevice = await _firebaseMessaging.getToken();
    final Map data = {'token': token, 'senha': password, 'dispositivoId': idDevice};
    final body = json.encode(data);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Redefinir');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final user = DataUser.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          _userService.create(user.data);
        }
        return user;
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = DataUser.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      log("[RecoverPassword] redefinePassword - Erro de requisição $stacktrace");
      throw Exception(e);
    }
  }
}
