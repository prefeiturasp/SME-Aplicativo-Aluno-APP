abstract class IRecoverPasswordRepository {
  Future<String> sendToken(String cpf);
  Future<String> validateToken(String token);
}
