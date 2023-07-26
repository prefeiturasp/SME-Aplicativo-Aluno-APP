import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../interfaces/outros_servicos_repository_interface.dart';
import '../models/outros_servicos/outro_servico.model.dart';
import '../stores/usuario.store.dart';
import '../utils/app_config_reader.dart';

class OutrosServicosRepository implements IOutrosServicosRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  @override
  Future<List<OutroServicoModel>> obterLinksPioritario() async {
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/outroservico/links/destaque');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
      );

      final List<OutroServicoModel> retorno = [];

      if (response.statusCode == 200) {
        final interable = jsonDecode(response.body);
        for (var i = 0; i < interable.length; i++) {
          retorno.add(OutroServicoModel.fromMap(interable[i]));
        }
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Links  obterLinksPioritario $stacktrace');
      return List<OutroServicoModel>() = [];
    }
  }

  @override
  Future<bool> verificarSeRelatorioExiste(String codigoRelatorio) async {
    try {
      final String body = json.encode(codigoRelatorio);
      final url = Uri.parse('${AppConfigReader.getApiHost()}/relatorio/existe');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200 && response.body == 'true') {
        return true;
      } else {
        log('Erro ao obter dados');
        return false;
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Links  $stacktrace');
      throw Exception(e);
    }
  }

  @override
  Future<List<OutroServicoModel>> obterTodosLinks() async {
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/outroservico/links/lista');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
      );
      List<OutroServicoModel> retorno = [];

      if (response.statusCode == 200) {
        final interable = jsonDecode(response.body);
        for (var i = 0; i < interable.length; i++) {
          retorno.add(OutroServicoModel.fromMap(interable[i]));
        }
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Links  $stacktrace');
      throw Exception(e);
    }
  }
}
