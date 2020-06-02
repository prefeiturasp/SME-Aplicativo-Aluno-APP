import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/repositories/authenticate_repository.dart';
import 'package:sme_app_aluno/utils/storage.dart';

part 'authenticate.controller.g.dart';

class AuthenticateController = _AuthenticateControllerBase
    with _$AuthenticateController;

abstract class _AuthenticateControllerBase with Store {
  final Storage _storage = Storage();
  AuthenticateRepository _authenticateRepository;

  _AuthenticateControllerBase() {
    _authenticateRepository = AuthenticateRepository();
    loadCurrentUser();
  }

  @observable
  Data currentUser;

  @observable
  bool isLoading = false;

  @observable
  String currentName;

  @observable
  String currentCPF;

  @observable
  String currentEmail;

  @observable
  String currentPassword;

  @observable
  String token;

  @action
  authenticateUser(String cpf, String password, bool onBackgroundFetch) async {
    isLoading = true;
    currentUser = await _authenticateRepository.loginUser(
        cpf, password, onBackgroundFetch);
    isLoading = false;
  }

  @action
  clearCurrentUser() {
    currentUser = null;
  }

  @action
  Future<void> loadCurrentUser() async {
    currentName = await _storage.readValueStorage('current_name');
    currentCPF = await _storage.readValueStorage('current_cpf');
    currentEmail = await _storage.readValueStorage('current_email');
    currentPassword = await _storage.readValueStorage('current_password');
    token = await _storage.readValueStorage('token');
  }
}
