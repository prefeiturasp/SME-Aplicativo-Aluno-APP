import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings/data.dart';
import '../../repositories/settings_repository.dart';

part 'settings.controller.g.dart';

class SettingsController = SettingsControllerBase with _$SettingsController;

abstract class SettingsControllerBase with Store {
  final SettingsRepository _settingsRepository = SettingsRepository();

  @observable
  Data? data;

  @observable
  bool isLoading = false;

  Future<String> obterNumeroVersaoApp() async {
    final prefs = await SharedPreferences.getInstance();
    final versao = prefs.getString('versaoApp');
    final valor = versao != null ? 'Versão ${versao.toString().replaceAll('"', '')}' : '';
    return valor;
  }

  @action
  Future<void> changePassword(String password, String oldPassword, int userId) async {
    isLoading = true;
    data = await _settingsRepository.changePassword(password, oldPassword, userId);
    isLoading = false;
  }
}
