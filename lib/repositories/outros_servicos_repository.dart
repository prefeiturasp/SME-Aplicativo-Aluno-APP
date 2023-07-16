import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/interfaces/outros_servicos_repository_interface.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';
import 'package:http/http.dart' as http;

class OutrosServicosRepository implements IOutrosServicosRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  @override
  Future<List<OutroServicoModel>> obterLinksPioritario() async {
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/outroservico/links/destaque");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${usuarioStore.usuario.token}",
        "Content-Type": "application/json",
      });

      List<OutroServicoModel> retorno = [];

      if (response.statusCode == 200) {
        Iterable interable = jsonDecode(response.body);
        retorno = List<OutroServicoModel>.from(interable.map((model) => OutroServicoModel.fromJson(model)));
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      log("Erro ao carregar lista de Links  " + stacktrace.toString());
      throw Exception(e);
    }
  }

  @override
  Future<bool> verificarSeRelatorioExiste(String codigoRelatorio) async {
    try {
      String body = json.encode(codigoRelatorio);
      var url = Uri.https("${AppConfigReader.getApiHost()}/relatorio/existe");
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200 && response.body == "true") {
        return true;
      } else {
        log('Erro ao obter dados');
        return false;
      }
    } catch (e, stacktrace) {
      log("Erro ao carregar lista de Links  " + stacktrace.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<OutroServicoModel>> obterTodosLinks() async {
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/outroservico/links/lista");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${usuarioStore.usuario.token}",
        "Content-Type": "application/json",
      });
      List<OutroServicoModel> retorno = [];

      if (response.statusCode == 200) {
        Iterable interable = jsonDecode(response.body);
        retorno = List<OutroServicoModel>.from(interable.map((model) => OutroServicoModel.fromJson(model)));
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      log("Erro ao carregar lista de Links  " + stacktrace.toString());
      throw Exception(e);
    }
  }
}
