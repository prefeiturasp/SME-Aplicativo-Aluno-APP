import 'package:sme_app_aluno/models/first_access/data.dart';

abstract class IFirstAccessRepository {
  Future<Data> changeNewPassword(int id, String password);

  Future<Data> changeEmailAndPhone(String email, String phone);
}
