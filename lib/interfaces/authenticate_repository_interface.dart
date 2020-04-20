import 'package:sme_app_aluno/models/data.dart';

abstract class IAuthenticateRepository {
  Future<Data> loginUser(String cpf, String password);
}
