import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../interfaces/authenticate_repository_interface.dart';
import '../models/index.dart';
import '../utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<UsuarioDataModel> loginUser(String cpf, String password) async {
    String? idDevice = '';

    idDevice = await _firebaseMessaging.getToken();

    log('FIREBASE TOKEN: $idDevice');

    final Map parametrosLogin = {
      'cpf': cpf,
      'senha': password,
      'dispositivoId': idDevice,
    };

    final body = json.encode(parametrosLogin);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final user = UsuarioDataModel.fromJson(response.body);
        return user;
      } else {
        log('Erro ao tentar se autenticar ${response.statusCode}');
        return UsuarioDataModel(ok: false, erros: ['Erro ao tentar se autenticar'], data: UsuarioModel.clear());
      }
    } catch (error, stacktrace) {
      log('Erro ao tentar se autenticar $stacktrace');
      return UsuarioDataModel(ok: false, erros: ['Erro ao tentar se autenticar'], data: UsuarioModel.clear());
    }
  }
}
