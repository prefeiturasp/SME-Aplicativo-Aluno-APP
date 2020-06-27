import 'package:sme_app_aluno/models/first_access/data.dart';

abstract class IFirstAccessRepository {
  Future<Data> changeNewPassword(int id, String password);

  Future<Data> changeEmail(int id, String email);

  Future<Data> changePhone(int id, String phone);
}
