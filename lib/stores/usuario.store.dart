import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/index.dart';

part 'usuario.store.g.dart';

class UsuarioStore = _UsuarioStoreBase with _$UsuarioStore;

abstract class _UsuarioStoreBase with Store {
  @observable
  bool carregando = false;

  @observable
  int id = null;

  @observable
  String cpf = null;

  @observable
  UsuarioModel usuario = new UsuarioModel();

  @observable
  String token = null;

  @action
  carregarUsuario() async {
    carregando = true;
    final prefs = await SharedPreferences.getInstance();
    var prefsUsuario = prefs.getString("eaUsuario");
    if (prefsUsuario != null) {
      usuario = UsuarioModel.fromJson(jsonDecode(prefsUsuario));
      id = usuario?.id;
      cpf = usuario?.cpf;
      token = usuario?.token;
    }
    carregando = false;
  }

  @action
  atualizarDados(String email, DateTime dataNascimento, String nomeMae,
      String telefone, DateTime ultimaAtualizacao) async {
    carregando = true;

    final prefs = await SharedPreferences.getInstance();

    if (usuario != null) {
      usuario.email = email;
      usuario.dataNascimento = dataNascimento;
      usuario.nomeMae = nomeMae;
      usuario.celular = telefone;
      usuario.primeiroAcesso = false;
      usuario.atualizarDadosCadastrais = false;
      usuario.ultimaAtualizacao = ultimaAtualizacao;
      await prefs.setString('eaUsuario', jsonEncode(usuario.toJson()));
    }

    carregando = false;
  }

  @action
  Future<void> atualizaPrimeiroAcesso(bool primeiroAcesso) async {
    final prefs = await SharedPreferences.getInstance();
    if (usuario != null) {
      usuario.primeiroAcesso = primeiroAcesso;
      await prefs.setString('eaUsuario', jsonEncode(usuario.toJson()));
    }
  }

  @action
  Future<void> limparUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    usuario = null;
    token = null;
    prefs.clear();
  }
}
