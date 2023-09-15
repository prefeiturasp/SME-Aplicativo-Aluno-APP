import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../interfaces/authenticate_repository_interface.dart';
import '../models/index.dart';
import '../utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  @override
  Future<UsuarioDataModel> loginUser(String cpf, String password) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    String? idDevice = '';
    await Future.delayed(const Duration(seconds: 2));
    idDevice = await firebaseMessaging.getToken();
    await Future.delayed(const Duration(seconds: 3));
    log('FIREBASE TOKEN: $idDevice');

    final Map parametrosLogin = {
      'cpf': cpf,
      'senha': password,
      'dispositivoId': idDevice,
    };

    final body = json.encode(parametrosLogin);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao');
      final response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      )
          .timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Erro ao tentar se autenticar', 408); // Request Timeout response status code
        },
      );

      if (response.statusCode == 200) {
        final user = UsuarioDataModel.fromJson(response.body);
        return user;
      } else if (response.statusCode == 408) {
        final usuarioRetorno = UsuarioDataModel(ok: false, erros: [response.body], data: UsuarioModel.clear());
        log('Erro ao tentar se autenticar status code ${response.statusCode}');
        return usuarioRetorno;
      } else {
        final erros = jsonDecode(response.body)['erros'] as List;
        final usuarioRetorno = UsuarioDataModel(ok: false, erros: [], data: UsuarioModel.clear());

        for (var i = 0; i < erros.length; i++) {
          usuarioRetorno.erros.add(erros[i]);
        }
        log('Erro ao tentar se autenticar status code ${response.statusCode}');
        return usuarioRetorno;
      }
    } catch (error, stacktrace) {
      log('Erro ao tentar se autenticar $stacktrace');
      return UsuarioDataModel(ok: false, erros: ['Erro ao tentar se autenticar'], data: UsuarioModel.clear());
    }
  }
}
