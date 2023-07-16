import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/change_email_and_phone/data_change_email_and_phone.dart';
import 'package:sme_app_aluno/models/first_access/data.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/repositories/first_access_repository.dart';
import 'package:sme_app_aluno/services/user.service.dart';

part 'first_access.controller.g.dart';

class FirstAccessController = FirstAccessControllerBase with _$FirstAccessController;

abstract class FirstAccessControllerBase with Store {
  late final FirstAccessRepository firstAccessRepository;
  final UserService _userService = UserService();
  FirstAccessControllerBase() {
    this.firstAccessRepository = FirstAccessRepository();
  }

  @observable
  late Data data;

  @observable
  late DataChangeEmailAndPhone dataEmailOrPhone;

  bool isLoading = false;

  @observable
  late String currentEmail;

  @observable
  late String currentPhone;

  @action
  changeNewPassword(int id, String password) async {
    isLoading = true;
    data = await firstAccessRepository.changeNewPassword(id, password);
    isLoading = false;
  }

  @action
  changeEmailAndPhone(String email, String phone, int userId, bool changePassword) async {
    isLoading = true;
    dataEmailOrPhone = await firstAccessRepository.changeEmailAndPhone(email, phone, userId, changePassword);
    isLoading = false;
  }

  @action
  loadUserForStorage(int userId) async {
    User user = await _userService.find(userId);
    currentEmail = user.email;
    currentPhone = user.celular;
  }
}
