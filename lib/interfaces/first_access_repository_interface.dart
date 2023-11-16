import '../models/change_email_and_phone/data_change_email_and_phone.dart';
import '../models/first_access/data.dart';

abstract class IFirstAccessRepository {
  Future<Data> changeNewPassword(int id, String password);

  Future<DataChangeEmailAndPhone> changeEmailAndPhone(
      String email, String phone, int userId, bool changePassword,);
}
