import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

import '../interfaces/boletim_aluno_repository_interface.dart';
import '../stores/usuario.store.dart';
import '../utils/app_config_reader.dart';

class BoletimAlunoRepository implements IBoletimRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  @override
  Future<bool> solicitarBoletim({
    required String dreCodigo,
    required String ueCodigo,
    required int semestre,
    required String turmaCodigo,
    required int anoLetivo,
    required int modalidadeCodigo,
    required int modelo,
    required String alunoCodigo,
  }) async {
    final url = Uri.parse('${AppConfigReader.getApiHost()}/Relatorio/boletim');
    final Map data = {
      'dreCodigo': dreCodigo,
      'ueCodigo': ueCodigo,
      'semestre': semestre,
      'turmaCodigo': turmaCodigo,
      'anoLetivo': anoLetivo,
      'modalidadeCodigo': modalidadeCodigo,
      'modelo': modelo,
      'alunoCodigo': alunoCodigo,
    };
    final String body = json.encode(data);
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return response.body == true.toString() ? true : false;
      }
      return false;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException(e);
      return false;
    }
  }
}
