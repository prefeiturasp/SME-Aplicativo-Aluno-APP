import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/IRelatorioRaaRepository.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class RelatorioRaaRepository implements IRelatorioRaaRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<bool> solicitarRelatorioRaa(
      {
      required String dreCodigo,
      required String ueCodigo,
      required int semestre,
      required String turmaCodigo,
      required int anoLetivo,
      required int modalidadeCodigo,
      required String alunoCodigo}) async {
    var url = Uri.https("${AppConfigReader.getApiHost()}/Relatorio/raa");
    Map _parametros = {
      "dreCodigo": dreCodigo,
      "ueCodigo": ueCodigo,
      "semestre": semestre,
      "turmaCodigo": turmaCodigo,
      "anoLetivo": anoLetivo,
      "modalidadeCodigo": modalidadeCodigo,
      "alunoCodigo": alunoCodigo,
    };
    String body = json.encode(_parametros);
    try {
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200)
        return response.body == true.toString() ? true : false;
      else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
