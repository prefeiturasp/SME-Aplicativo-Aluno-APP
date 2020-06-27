import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/first_access/data.dart';
import 'package:sme_app_aluno/repositories/first_access_repository.dart';

part 'first_access.controller.g.dart';

class FirstAccessController = _FirstAccessControllerBase
    with _$FirstAccessController;

abstract class _FirstAccessControllerBase with Store {
  FirstAccessRepository _firstAccessRepository;

  _FirstAccessControllerBase() {
    _firstAccessRepository = FirstAccessRepository();
  }

  @observable
  Data data;

  @observable
  Data dataEmailOrPhone;

  @observable
  bool isLoading = false;

  @action
  changeNewPassword(int id, String password) async {
    isLoading = true;
    data = await _firstAccessRepository.changeNewPassword(id, password);
    isLoading = false;
  }

  @action
  changeEmail(int id, String email) async {
    isLoading = true;
    dataEmailOrPhone = await _firstAccessRepository.changeEmail(id, email);
    isLoading = false;
  }

  @action
  changePhone(int id, String phone) async {
    isLoading = true;
    dataEmailOrPhone = await _firstAccessRepository.changePhone(id, phone);
    isLoading = false;
  }
}
