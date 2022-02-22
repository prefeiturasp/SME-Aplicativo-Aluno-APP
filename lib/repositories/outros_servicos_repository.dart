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
      var url = "${AppConfigReader.getApiHost()}/outroservico/links/destaque";
      var response = await http.get(url);
      List mapOutrosServico = [];
      var outrosServico = [];
      List<OutroServicoModel> retorno = [];
      for (var i = 0; i < outrosServico.length; i++) {
        mapOutrosServico.add(outrosServico[i].toJson());
      }
      if (response.statusCode == 200) {
        print(response);
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Links  " + stacktrace.toString());
    }
  }

  @override
  Future<List<OutroServicoModel>> obterTodosLinks() async {
    try {
      var url = "${AppConfigReader.getApiHost()}/outrosservicos/links/lista";
      var response = await http.get(url);
      List mapOutrosServico = [];
      var outrosServico = [];
      List<OutroServicoModel> retorno = [];
      for (var i = 0; i < outrosServico.length; i++) {
        mapOutrosServico.add(outrosServico[i].toJson());
      }
      if (response.statusCode == 200) {
        print(response);
        return retorno;
      } else {
        return retorno;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Links  " + stacktrace.toString());
    }
  }
}
