import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/user.dart';
import 'package:sme_app_aluno/utils/api.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  AuthenticateController authenticateController;

  @override
  Future<User> loginUser(String cpf, String password) async {
    try {
      final response =
          await http.post("${Api.HOST}/Autenticacao?cpf=$cpf&senha=$password");

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        User currentUser = User.fromJson(decodeJson);
        addCurrentUserToStorage(
          currentUser.data.nome,
          currentUser.data.cpf,
          currentUser.data.email,
          currentUser.data.token,
        );
        return currentUser;
      } else {
        print("Erro ao tentatar se autenticar ");
        return null;
      }
    } catch (error, stacktrace) {
      print("Erro ao tentatar se autenticar " + stacktrace.toString());
      return null;
    }
  }

  addCurrentUserToStorage(
      String name, String cpf, String email, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('current_name', name);
      prefs.setString('current_cpf', cpf);
      prefs.setString('current_email', email);
      prefs.setString('token', token);
    } catch (e) {
      print("Erro ao gravar no local storage $e");
    }
  }
}
