import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/repositories/usuario.repository.dart';

class UsuarioController {
  bool carregando = false;
  final usuarioRepository = GetIt.I.get<UsuarioRepository>();

  Future<ResponseDTO> atualizarDados(
    String nomeMae,
    DateTime dataNascimento,
    String email,
    String telefone,
  ) async {
    carregando = true;
    var response = await usuarioRepository.atualizar(
        nomeMae, dataNascimento, email, telefone);
    carregando = false;
    return response;
  }
}
