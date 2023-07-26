import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Future<UsuarioDataModel> loginUser(String cpf, String password) async {
    String idDevice = '';

    idDevice = await _firebaseMessaging.getToken();

    print("FIREBASE TOKEN: $idDevice");

    Map _data = {
      "cpf": cpf,
      "senha": password,
      "dispositivoId": idDevice,
    };

    var body = json.encode(_data);

    try {
      final response = await http.post(
        "${AppConfigReader.getApiHost()}/Autenticacao",
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = UsuarioDataModel.fromJson(decodeJson);
        return user;
      } else if (response.statusCode == 408) {
        return UsuarioDataModel(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = UsuarioDataModel.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log("Erro ao tentar se autenticar " + stacktrace.toString());
      return null;
    }
  }
}
