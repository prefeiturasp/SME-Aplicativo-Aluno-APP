import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/index.dart';

part 'usuario.store.g.dart';

class UsuarioStore = _UsuarioStoreBase with _$UsuarioStore;

abstract class _UsuarioStoreBase with Store {
  SharedPreferences prefs;

  @observable
  bool carregando = false;

  @observable
  Usuario usuario = new Usuario();

  @action
  carregarUsuario() async {
    carregando = true;
    prefs = await SharedPreferences.getInstance();
    var prefsUsuario = prefs.getString("eaUsuario");
    if (prefsUsuario != null) {
      usuario = Usuario.fromJson(jsonDecode(prefsUsuario));
    }
    carregando = false;
  }

  @action
  atualizarDados(String email, DateTime dataNascimento, String nomeMae,
      String telefone, DateTime ultimaAtualizacao) async {
    carregando = true;

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
    if (usuario != null) {
      usuario.primeiroAcesso = primeiroAcesso;
      await prefs.setString('eaUsuario', jsonEncode(usuario.toJson()));
    }
  }

  @action
  Future<void> limparUsuario() async {
    usuario = null;
    prefs.clear();
  }
}
