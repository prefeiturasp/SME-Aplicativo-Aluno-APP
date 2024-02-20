import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

import '../interfaces/authenticate_repository_interface.dart';
import '../models/index.dart';
import '../utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  @override
  Future<UsuarioDataModel> loginUser(String cpf, String password) async {
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      String? idDevice = '';
      await Future.delayed(const Duration(seconds: 2));
      idDevice = await firebaseMessaging.getToken();
      await Future.delayed(const Duration(seconds: 3));

      final Map parametrosLogin = {
        'cpf': cpf,
        'senha': password,
        'dispositivoId': idDevice,
      };

      final body = json.encode(parametrosLogin);

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
      } else if (response.statusCode == 408) {
        final usuarioRetorno = UsuarioDataModel(ok: false, erros: [response.body], data: UsuarioModel.clear());
        GetIt.I.get<SentryClient>().captureException('Erro ao tentar se autenticar status code ${response.statusCode}');
        return usuarioRetorno;
      } else {
        final erros = jsonDecode(response.body)['erros'] as List;
        final usuarioRetorno = UsuarioDataModel(ok: false, erros: [], data: UsuarioModel.clear());
        GetIt.I.get<SentryClient>().captureException('Erro ao tentar se autenticar  ${response.body}}');
        for (var i = 0; i < erros.length; i++) {
          usuarioRetorno.erros.add(erros[i]);
        }
        return usuarioRetorno;
      }
    } on DioException catch (error, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao tentar se autenticar  $error , $stacktrace}');
      return UsuarioDataModel(ok: false, erros: ['Erro ao tentar se autenticar'], data: UsuarioModel.clear());
    }
  }
}
