import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final Storage storage = Storage();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Future<Data> loginUser(String cpf, String password, onBackgroundFetch) async {
    String userPassword = await storage.readValueStorage("current_password");
    String idDevice = await _firebaseMessaging.getToken();
    print("FIREBASE TOKEN: $idDevice");

    if (!onBackgroundFetch) {
      var ids = new List<int>.generate(20, (i) => i + 1);
      ids.forEach((element) {
        print("Ids: $element");
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
          addCurrentUserToStorage(
            idDevice,
            user.data.nome,
            user.data.cpf,
            user.data.email ?? "",
            user.data.token,
            userPassword,
            user.data.id,
            user.data.celular,
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

  addCurrentUserToStorage(
    String dispositivoId,
    String name,
    String cpf,
    String email,
    String token,
    String password,
    int userId,
    String celular,
  ) async {
    storage.insertString('current_name', name);
    storage.insertString('current_cpf', cpf);
    storage.insertString('current_email', email);
    storage.insertString('token', token);
    storage.insertString('password', password);
    storage.insertString('dispositivo_id', dispositivoId);
    storage.insertInt('current_user_id', userId);
    storage.insertString('current_celular', celular);
    ;
  }
}
