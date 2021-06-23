import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/models/index.dart';

abstract class IUsuarioRepository {
  Future<ResponseDTO> atualizar(
      String nomeMae, DateTime dataNascimento, String email, String telefone);

  Future<UsuarioModel> obterDadosUsuario();
}
