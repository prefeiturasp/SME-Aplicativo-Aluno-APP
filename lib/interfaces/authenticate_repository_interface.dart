import 'package:sme_app_aluno/models/user/data.dart';

abstract class IAuthenticateRepository {
  Future<Data> loginUser(String cpf, String password, bool onBackgroundFetch);

  Future<Data> fetchFirstAccess(int id, String novaSenha);
}
