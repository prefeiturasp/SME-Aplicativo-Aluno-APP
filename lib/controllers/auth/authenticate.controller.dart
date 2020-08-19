import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/repositories/authenticate_repository.dart';
import 'package:sme_app_aluno/services/user.service.dart';

part 'authenticate.controller.g.dart';

class AuthenticateController = _AuthenticateControllerBase
    with _$AuthenticateController;

abstract class _AuthenticateControllerBase with Store {
  final UserService _userService = UserService();
  AuthenticateRepository _authenticateRepository;

  _AuthenticateControllerBase() {
    _authenticateRepository = AuthenticateRepository();
    loadCurrentUser();
  }

  @observable
  User user;

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

  @observable
  bool firstAccess;

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
    isLoading = true;
    List<User> users = await _userService.all();
    if (users.isNotEmpty) {
      user = users[0];
    }
    isLoading = false;
  }
}
