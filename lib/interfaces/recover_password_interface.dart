import 'package:sme_app_aluno/models/recover_password/data.dart';
import 'package:sme_app_aluno/models/recover_password/data_user.dart';

abstract class IRecoverPasswordRepository {
  Future<Data> sendToken(String cpf);
  Future<Data> validateToken(String token);
  Future<DataUser> redefinePassword(String password, String token);
}
