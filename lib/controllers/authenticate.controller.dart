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
    print("Iniciando o controler de autenticação");
  }

  @observable
  User currentUser;

  @observable
  bool isLoading = false;

  @observable
  String currentName;

  @observable
  String currentCPF;

  @observable
  String currentEmail;

  @observable
  String token;

  @observable
  String errorMessage;

  @action
  changeValue(String value) {
    print(value);
    String newValue = value;
    errorMessage = newValue;
  }

  @action
  authenticateUser(String cpf, String password) async {
    isLoading = true;
    currentUser = await _authenticateRepository.loginUser(cpf, password);
    isLoading = false;
  }

  @action
  Future<void> loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDataName = prefs.containsKey('current_name');
    bool isDataCPF = prefs.containsKey('current_cpf');
    if (isDataName && isDataCPF) {
      currentName = prefs.getString('current_name') ?? "";
      currentCPF = prefs.getString('current_cpf') ?? "";
      currentEmail = prefs.getString('current_email') ?? "";
      token = prefs.getString('token') ?? "";
    }
  }
}
