import 'package:sme_app_aluno/models/user.dart';

abstract class IAuthenticateRepository {
  Future<User> authenticateUser();
}
