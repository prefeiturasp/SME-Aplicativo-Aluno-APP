import '../models/settings/data.dart';

abstract class ISettingsRepository {
  Future<Data> changePassword(String password, String oldPassword, int userId);
}
