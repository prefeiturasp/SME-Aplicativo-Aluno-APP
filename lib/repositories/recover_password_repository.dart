import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dtos/validacao_erro_dto.dart';
import '../interfaces/recover_password_interface.dart';
import '../models/recover_password/data.dart';
import '../models/recover_password/data_user.dart';
import '../stores/usuario.store.dart';
import '../utils/app_config_reader.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<Data> sendToken(String cpf) async {
    final cpfUnformat = cpf.replaceAll(RegExp(r'[^\w\s]+'), '');
    final Map data0 = {
      'cpf': cpfUnformat,
    };
    final body = json.encode(data0);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = Data.fromJson(response.body);
        return data;
      } else if (response.statusCode == 408) {
        return Data(
          ok: false,
          erros: [AppConfigReader.getErrorMessageTimeOut()],
          validacaoErros: ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []),
          email: '',
        );
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao enviar token  $e , $stacktrace}');
      throw Exception(e);
    }
  }

  @override
  Future<Data> validateToken(String token) async {
    final Map data0 = {
      'token': token,
    };
    final body = json.encode(data0);
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Token/Validar');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final data = Data.fromJson(response.body);
        return data;
      } else {
        final dataError = Data.fromJson(response.body);
        return dataError;
      }
    } catch (e, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao validar token  $e , $stacktrace}');
      throw Exception(e);
    }
  }

  @override
  Future<DataUser> redefinePassword(String password, String token) async {
    final String? idDevice = await _firebaseMessaging.getToken();
    final usuarioStore = GetIt.I.get<UsuarioStore>();
    final Map data = {'token': token, 'senha': password, 'dispositivoId': idDevice};
    final body = json.encode(data);

    final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/Senha/Redefinir');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      final user = DataUser.fromJson(response.body);
      if (user.data!.cpf.isNotEmpty) {
        await usuarioStore.limparUsuario();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('eaUsuario', jsonEncode(user.data!.toJson()));
        await usuarioStore.carregarUsuario();
      }
      return user;
    } else {
      final dataError = DataUser.fromJson(response.body);
      return dataError;
    }
  }
}
