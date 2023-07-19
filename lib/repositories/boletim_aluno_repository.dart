import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/boletim_aluno_repository_interface.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

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
    var url = Uri.https("${AppConfigReader.getApiHost()}/Relatorio/boletim");
    Map _data = {
      "dreCodigo": dreCodigo,
      "ueCodigo": ueCodigo,
      "semestre": semestre,
      "turmaCodigo": turmaCodigo,
      "anoLetivo": anoLetivo,
      "modalidadeCodigo": modalidadeCodigo,
      "modelo": modelo,
      "alunoCodigo": alunoCodigo
    };
    String body = json.encode(_data);
    try {
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return response.body == true.toString() ? true : false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
