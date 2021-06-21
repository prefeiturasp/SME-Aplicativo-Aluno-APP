import 'package:sme_app_aluno/dtos/response.dto.dart';

abstract class IUsuarioRepository {
  Future<ResponseDTO> atualizar(
      String nomeMae, DateTime dataNascimento, String email, String telefone);
}
