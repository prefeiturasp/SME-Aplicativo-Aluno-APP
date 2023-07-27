import 'package:mobx/mobx.dart';

import '../../models/change_email_and_phone/data_change_email_and_phone.dart';
import '../../models/first_access/data.dart';
import '../../models/user/user.dart';
import '../../repositories/first_access_repository.dart';
import '../../services/user.service.dart';

part 'first_access.controller.g.dart';

class FirstAccessController = FirstAccessControllerBase with _$FirstAccessController;

abstract class FirstAccessControllerBase with Store {
  final FirstAccessRepository firstAccessRepository = FirstAccessRepository();
  final UserService _userService = UserService();

  @observable
  Data? data;

  @observable
  DataChangeEmailAndPhone dataEmailOrPhone = DataChangeEmailAndPhone();

  bool isLoading = false;

  @observable
  String currentEmail = '';

  @observable
  String currentPhone = '';

  @action
  Future<void> changeNewPassword(int id, String password) async {
    isLoading = true;
    data = await firstAccessRepository.changeNewPassword(id, password);
    isLoading = false;
  }

  @action
  Future<void> changeEmailAndPhone(String email, String phone, int userId, bool changePassword) async {
    isLoading = true;
    dataEmailOrPhone = await firstAccessRepository.changeEmailAndPhone(email, phone, userId, changePassword);
    isLoading = false;
  }

  @action
  Future<void> loadUserForStorage(int userId) async {
    final User user = await _userService.find(userId);
    currentEmail = user.email;
    currentPhone = user.celular;
  }
}
