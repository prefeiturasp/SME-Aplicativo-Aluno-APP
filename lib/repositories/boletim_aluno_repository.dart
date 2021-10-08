import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/interfaces/boletim_aluno_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class BoletimAlunoRepository implements IBoletimRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  @override
  Future<bool> solicitarBoletim({
    String dreCodigo,
    String ueCodigo,
    int semestre,
    String turmaCodigo,
    int anoLetivo,
    int modalidadeCodigo,
    int modelo,
    String alunoCodigo,
  }) async {
    var url = "${AppConfigReader.getApiHost()}/Aluno/notas/imprimirboletim";
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
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
