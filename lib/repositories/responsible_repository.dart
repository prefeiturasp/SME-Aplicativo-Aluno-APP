import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

import '../interfaces/responsible_repository_interface.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class ResponsibleRepository implements IResponsibleRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    try {
      final url = Uri.parse(
        '${AppConfigReader.getApiHost()}/Autenticacao/usuario/responsavel?cpf=${usuarioStore.usuario!.cpf}',
      );
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${usuarioStore.usuario!.token}', 'Content-Type': 'application/json'},
      );

      log('Request: ${response.statusCode} - ${response.request} | ${response.body} ');

      if (response.statusCode == 200) {
        return response.body == 'true' ? true : false;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao verificar se resposável tem aluno: $stacktrace');
      return false;
    }
  }
}
