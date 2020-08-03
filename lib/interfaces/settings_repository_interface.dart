import 'package:sme_app_aluno/models/settings/data.dart';

abstract class ISettingsRepository {
  Future<Data> changePassword(String password, String oldPassword);
}
