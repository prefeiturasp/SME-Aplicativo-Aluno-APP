import 'package:sme_app_aluno/models/recover_password/data.dart';

abstract class IRecoverPasswordRepository {
  Future<Data> sendToken(String cpf);
  Future<String> validateToken(String token);
}
