import '../models/index.dart';

abstract class IAuthenticateRepository {
  Future<UsuarioDataModel> loginUser(String cpf, String password);
}
