import '../../dtos/response.dto.dart';
import '../../models/index.dart';

abstract class IUsuarioRepository {
  Future<ResponseDTO> atualizar(
      String nomeMae, DateTime dataNascimento, String email, String telefone,);

  Future<UsuarioModel> obterDadosUsuario();
}
