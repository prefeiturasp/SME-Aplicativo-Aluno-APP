import 'dart:convert';
import 'package:device_info/device_info.dart';
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

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String idDevice = androidInfo.id;

    try {
      final response = await http.post(
          "${Api.HOST}/Autenticacao?cpf=$cpf&senha=$password&dispositivoId=$idDevice");

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = Data.fromJson(decodeJson);
        if (user.data.cpf.isNotEmpty) {
          addCurrentUserToStorage(
            androidInfo.id,
            user.data.nome,
            user.data.cpf,
            user.data.email ?? "",
            user.data.token,
            userPassword,
            user.data.id,
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

  addCurrentUserToStorage(String dispositivoId, String name, String cpf,
      String email, String token, String password, int userId) async {
    storage.insertString('current_id', name);
    storage.insertString('current_name', name);
    storage.insertString('current_cpf', cpf);
    storage.insertString('current_email', email);
    storage.insertString('token', token);
    storage.insertString('password', password);
    storage.insertString('dispositivo_id', dispositivoId);
    storage.insertInt('current_user_id', userId);
  }
}
