import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';

part 'usuario.store.g.dart';

class UsuarioStore = _UsuarioStoreBase with _$UsuarioStore;

abstract class _UsuarioStoreBase with Store {
  @observable
  bool carregando = false;

  @observable
  int id = 0;

  @observable
  String cpf = '';

  @observable
  UsuarioModel usuario = UsuarioModel(
    id: 0,
    nome: '',
    nomeMae: '',
    cpf: '',
    email: '',
    token: '',
    primeiroAcesso: false,
    atualizarDadosCadastrais: false,
    celular: '',
    dataNascimento: DateTime.now(),
    ultimaAtualizacao: DateTime.now(),
    senha: '',
  );

  @observable
  String token = '';

  @action
  carregarUsuario() async {
    carregando = true;
    final prefs = await SharedPreferences.getInstance();
    final prefsUsuario = prefs.getString('eaUsuario');
    if (prefsUsuario != null) {
      usuario = UsuarioModel.fromJson(jsonDecode(prefsUsuario));
      id = usuario.id;
      cpf = usuario.cpf;
      token = usuario.token;
    }
    carregando = false;
  }

  @action
  atualizarDados(
    String email,
    DateTime dataNascimento,
    String nomeMae,
    String telefone,
    DateTime? ultimaAtualizacao,
  ) async {
    carregando = true;

    final prefs = await SharedPreferences.getInstance();

    usuario.email = email;
    usuario.dataNascimento = dataNascimento;
    usuario.nomeMae = nomeMae;
    usuario.celular = telefone;
    usuario.primeiroAcesso = false;
    usuario.atualizarDadosCadastrais = false;
    usuario.ultimaAtualizacao = ultimaAtualizacao;
    await prefs.setString('eaUsuario', jsonEncode(usuario.toJson()));

    carregando = false;
  }

  @action
  Future<void> atualizaPrimeiroAcesso(bool primeiroAcesso) async {
    final prefs = await SharedPreferences.getInstance();
    usuario.primeiroAcesso = primeiroAcesso;
    await prefs.setString('eaUsuario', jsonEncode(usuario.toJson()));
  }

  @action
  Future<void> limparUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    usuario.clear();
    token = '';
    prefs.clear();
  }
}
