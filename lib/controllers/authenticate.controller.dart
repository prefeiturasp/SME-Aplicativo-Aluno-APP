import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/models/user.dart';
import 'package:sme_app_aluno/repositories/authenticate_repository.dart';

part 'authenticate.controller.g.dart';

class AuthenticateController = _AuthenticateControllerBase
    with _$AuthenticateController;

abstract class _AuthenticateControllerBase with Store {
  AuthenticateRepository _authenticateRepository;

  _AuthenticateControllerBase() {
    _authenticateRepository = AuthenticateRepository();
    loadCurrentUser();
  }

  @observable
  User currentUser;

  @observable
  String currentName;

  @observable
  String currentCPF;

  @observable
  String currentEmail;

  @observable
  String token;

  @action
  authenticateUser(String cpf, String password) async {
    currentUser = await _authenticateRepository.loginUser(cpf, password);
  }

  @action
  Future<void> loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isData = prefs.containsKey('current_user');
    print(isData);
    if (isData) {
      currentName = prefs.getString('current_name') ?? "";
      currentCPF = prefs.getString('current_cpf') ?? "";
      currentEmail = prefs.getString('current_email') ?? "";
      token = prefs.getString('token') ?? "";
    }
  }
}
