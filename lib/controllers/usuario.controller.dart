import 'dart:js_interop';

import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/repositories/usuario.repository.dart';
import 'package:sme_app_aluno/stores/index.dart';

class UsuarioController {
  bool carregando = false;
  final usuarioRepository = GetIt.I.get<UsuarioRepository>();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<ResponseDTO> atualizarDados(
    String nomeMae,
    DateTime dataNascimento,
    String email,
    String telefone,
  ) async {
    carregando = true;
    var response = await usuarioRepository.atualizar(nomeMae, dataNascimento, email, telefone);
    carregando = false;
    return response;
  }

  Future<void> obterDadosUsuario() async {
    var usuario = await usuarioRepository.obterDadosUsuario();

    if (!usuario.isNull) {
      usuarioStore.atualizarDados(
          usuario.email, usuario.dataNascimento, usuario.nomeMae, usuario.celular, usuario.ultimaAtualizacao);
    }
  }
}
