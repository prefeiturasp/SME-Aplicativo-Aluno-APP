import 'package:sme_app_aluno/models/user/data.dart';

abstract class IFirstAccessRepository {
  Future<Data> changeNewPassword(int id, String password);
}
