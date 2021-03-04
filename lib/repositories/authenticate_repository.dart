import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserService _userService = UserService();

  @override
  Future<Data> loginUser(String cpf, String password) async {
    String idDevice;
    if (Platform.isAndroid) {
      idDevice = await _firebaseMessaging.getToken();
    } else if (Platform.isIOS) {
      idDevice = 'noToken';
    }

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
        var user = Data.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          _userService.create(user.data);
        }
        return user;
      } else if (response.statusCode == 408) {
        return Data(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      print("Erro ao tentar se autenticar " + stacktrace.toString());
      return null;
    }
  }
}
