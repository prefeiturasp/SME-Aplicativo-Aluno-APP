// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:js_interop';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/repositories/authenticate_repository.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';

class AutenticacaoController {
  late final AuthenticateRepository repository;
  AutenticacaoController() {
    this.repository = AuthenticateRepository();
  }
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<UsuarioDataModel> authenticateUser(String cpf, String password) async {
    var data = await repository.loginUser(cpf, password);

    if (!data.isNull) {
      return new UsuarioDataModel(data: UsuarioModel(), erros: [], ok: false);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('eaUsuario', jsonEncode(data.data.toJson()));
    await usuarioStore.carregarUsuario();

    return data;
  }
}
