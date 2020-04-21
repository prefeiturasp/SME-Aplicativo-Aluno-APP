import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final Storage storage = Storage();

  @override
  Future<Data> loginUser(String cpf, String password) async {
    String userPassword = await storage.readValueStorage("current_password");
    try {
      final response =
          await http.post("${Api.HOST}/Autenticacao?cpf=$cpf&senha=$password");

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = Data.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          addCurrentUserToStorage(
            user.data.nome,
            user.data.cpf,
            user.data.email,
            user.data.token,
            userPassword,
          );
        }
        return user;
      } else {
        Data dataError = Data();
        dataError.erros = [response.body];
        return dataError;
      }
    } catch (error, stacktrace) {
      print("Erro ao tentatar se autenticar " + stacktrace.toString());
      return null;
    }
  }

  addCurrentUserToStorage(String name, String cpf, String email, String token,
      String password) async {
    storage.insertString('current_name', name);
    storage.insertString('current_cpf', cpf);
    storage.insertString('current_email', email);
    storage.insertString('token', token);
    storage.insertString('token', password);
  }
}
