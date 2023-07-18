import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/settings/data.dart';
import 'package:sme_app_aluno/repositories/settings_repository.dart';

part 'settings.controller.g.dart';

class SettingsController = SettingsControllerBase with _$SettingsController;

abstract class SettingsControllerBase with Store {
  late final SettingsRepository _settingsRepository;

  SettingsControllerBase() {
    this._settingsRepository = SettingsRepository();
  }

  @observable
  late Data data;

  @observable
  bool isLoading = false;

  @action
  changePassword(String password, String oldPassword, int userId) async {
    isLoading = true;
    data = await _settingsRepository.changePassword(password, oldPassword, userId);
    isLoading = false;
  }
}
