import 'package:sme_app_aluno/models/change_email_and_phone/data_change_email_and_phone.dart';
import 'package:sme_app_aluno/models/first_access/data.dart';

abstract class IFirstAccessRepository {
  Future<Data> changeNewPassword(int id, String password);

  Future<DataChangeEmailAndPhone> changeEmailAndPhone(
      String email, String phone, int userId, bool changePassword);
}
