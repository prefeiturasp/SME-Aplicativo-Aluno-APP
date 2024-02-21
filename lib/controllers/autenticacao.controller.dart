// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';
import '../repositories/authenticate_repository.dart';
import '../stores/usuario.store.dart';

class AutenticacaoController {
  late final AuthenticateRepository repository;
  AutenticacaoController() {
    repository = AuthenticateRepository();
  }
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<String> obterNumeroVersaoApp() async {
    final prefs = await SharedPreferences.getInstance();
    final versao = prefs.getString('versaoApp');
    final valor = versao != null ? 'Versão ${versao.toString().replaceAll('"', '')}' : '';
    return valor;
  }

  Future<UsuarioDataModel> authenticateUser(String cpf, String password) async {
    try {
      final data = await repository.loginUser(cpf, password);
      if (data.ok) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('eaUsuario', jsonEncode(data.data.toJson()));
        await usuarioStore.carregarUsuario();
      } else {
        GetIt.I.get<SentryClient>().captureException(data);
      }
      return data;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('Erro ao tentar se autenticar AutenticacaoController $e');
      throw Exception(e);
    }
  }
}
