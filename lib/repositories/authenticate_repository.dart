import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<UsuarioDataModel> loginUser(String cpf, String password) async {
    final String idDevice = 'id_device3243';

    //final fcmToken = await FirebaseMessaging.instance.getToken();

    //idDevice = await _firebaseMessaging.getToken();

    log("FIREBASE TOKEN: $idDevice");

    Map _data = {
      "cpf": cpf,
      "senha": password,
      "dispositivoId": idDevice,
    };

    var body = json.encode(_data);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        //Erro AQUI
        var user = UsuarioDataModel.fromJson(decodeJson);
        return user;
      } else if (response.statusCode == 408) {
        log("Erro ao tentar se autenticar");
        throw Exception(response.statusCode);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = UsuarioDataModel.fromJson(decodeError);
        throw Exception(dataError);
      }
    } catch (error, stacktrace) {
      log("Erro ao tentar se autenticar " + stacktrace.toString());
      throw Exception(error);
    }
  }
}
