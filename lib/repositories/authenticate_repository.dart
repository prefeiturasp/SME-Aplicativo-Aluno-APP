import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final Storage _storage = Storage();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserService _userService = UserService();

  @override
  Future<Data> loginUser(String cpf, String password, onBackgroundFetch) async {
    String idDevice = await _firebaseMessaging.getToken();
    print("FIREBASE TOKEN: $idDevice");

    if (!onBackgroundFetch) {
      var ids = new List<int>.generate(20, (i) => i + 1);
      ids.forEach((element) {
        print("Remove ids: $element");
        _firebaseMessaging.unsubscribeFromTopic(element.toString());
      });
    }

    try {
      final response = await http.post(
          "${Api.HOST}/Autenticacao?cpf=$cpf&senha=$password&dispositivoId=$idDevice");

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = Data.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          _userService.create(user.data);
        }
        return user;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      print("Erro ao tentatar se autenticar " + stacktrace.toString());
      return null;
    }
  }

  addCurrentUserToStorage(
    String dispositivoId,
    String name,
    String cpf,
    String email,
    String token,
    String password,
    int userId,
    String celular,
    bool primeiroAcesso,
    bool informarCelularEmail,
  ) async {
    _storage.insertString('current_name', name);
    _storage.insertString('current_cpf', cpf);
    _storage.insertString('current_email', email);
    _storage.insertString('token', token);
    _storage.insertString('current_password', password);
    _storage.insertString('dispositivo_id', dispositivoId);
    _storage.insertInt('current_user_id', userId);
    _storage.insertString('current_celular', celular);
    _storage.insertBool('current_primeiro_acesso', primeiroAcesso);
    _storage.insertBool('current_informar_celular_email', informarCelularEmail);
  }
}
