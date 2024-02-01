import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../interfaces/relatorio_raa_repository_interface.dart';
import '../stores/usuario.store.dart';
import '../utils/app_config_reader.dart';

class RelatorioRaaRepository implements IRelatorioRaaRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<bool> solicitarRelatorioRaa({
    required String dreCodigo,
    required String ueCodigo,
    required int semestre,
    required String turmaCodigo,
    required int anoLetivo,
    required int modalidadeCodigo,
    required String alunoCodigo,
  }) async {
    final url = Uri.parse('${AppConfigReader.getApiHost()}/Relatorio/raa');
    final Map parametros = {
      'dreCodigo': dreCodigo,
      'ueCodigo': ueCodigo,
      'semestre': semestre,
      'turmaCodigo': turmaCodigo,
      'anoLetivo': anoLetivo,
      'modalidadeCodigo': modalidadeCodigo,
      'alunoCodigo': alunoCodigo,
    };
    final String body = json.encode(parametros);
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
      return false;
    }
  }
}
