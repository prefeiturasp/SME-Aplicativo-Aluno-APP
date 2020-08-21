import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/settings/data.dart';
import 'package:sme_app_aluno/repositories/settings_repository.dart';

part 'settings.controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  SettingsRepository _settingsRepository;

  _SettingsControllerBase() {
    _settingsRepository = SettingsRepository();
  }

  @observable
  Data data;

  @observable
  bool isLoading = false;

  @action
  changePassword(String password, String oldPassword, int userId) async {
    isLoading = true;
    data =
        await _settingsRepository.changePassword(password, oldPassword, userId);
    isLoading = false;
  }
}
