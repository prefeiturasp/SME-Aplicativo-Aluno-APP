import 'package:get_it/get_it.dart';

import '../dtos/response.dto.dart';
import '../repositories/usuario.repository.dart';
import '../stores/index.dart';

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
    final response = await usuarioRepository.atualizar(nomeMae, dataNascimento, email, telefone);
    carregando = false;
    return response;
  }

  Future<void> obterDadosUsuario() async {
    final usuario = await usuarioRepository.obterDadosUsuario();

    usuarioStore.atualizarDados(
      usuario.email,
      usuario.dataNascimento,
      usuario.nomeMae,
      usuario.celular,
      usuario.ultimaAtualizacao,
    );
  }
}
