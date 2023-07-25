// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
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

  Future<UsuarioDataModel> authenticateUser(String cpf, String password) async {
    try {
      final data = await repository.loginUser(cpf, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('eaUsuario', jsonEncode(data.data.toJson()));
      await usuarioStore.carregarUsuario();
      return data;
    } catch (e) {
      log(e.toString());
      // TODO: error remover esse return UsuarioDataModel antes de mandar para release e criar mensagem de erro
      return UsuarioDataModel(
        ok: false,
        erros: [e.toString()],
        data: UsuarioModel(
          id: 0,
          nome: '',
          nomeMae: '',
          cpf: cpf,
          email: '',
          token: '',
          primeiroAcesso: false,
          atualizarDadosCadastrais: false,
          celular: '',
          dataNascimento: DateTime.now(),
          ultimaAtualizacao: DateTime.now(),
          senha: '',
        ),
      );
      //throw Exception(e);
    }
  }
}
