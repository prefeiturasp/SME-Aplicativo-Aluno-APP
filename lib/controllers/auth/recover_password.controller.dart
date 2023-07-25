// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import '../../models/recover_password/data.dart';
import '../../models/recover_password/data_user.dart';
import '../../repositories/recover_password_repository.dart';

part 'recover_password.controller.g.dart';

class RecoverPasswordController = RecoverPasswordControllerBase with _$RecoverPasswordController;

RecoverPasswordRepository _recoverPasswordRepository = RecoverPasswordRepository();

abstract class RecoverPasswordControllerBase with Store {
  @observable
  Data? data;

  @observable
  DataUser? dataUser;

  @observable
  String email = '';

  @observable
  bool loading = false;

  @action
  Future<void> sendToken(String cpf) async {
    loading = true;
    data = await _recoverPasswordRepository.sendToken(cpf);
    loading = false;
  }

  @action
  Future<void> validateToken(String token) async {
    loading = true;
    data = await _recoverPasswordRepository.validateToken(token);
    loading = false;
  }

  @action
  Future<void> redefinePassword(String password, String token) async {
    loading = true;
    dataUser = await _recoverPasswordRepository.redefinePassword(password, token);
    loading = false;
  }
}
