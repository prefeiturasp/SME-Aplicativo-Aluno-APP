import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/models/ue/data_ue.dart';
import 'package:sme_app_aluno/services/api.service.dart';

class UERepository {
  final _api = GetIt.I.get<ApiService>();

  Future<DadosUE> obterPorCodigo(String codigoUe) async {
    try {
      var response = await _api.dio.get("/UnidadeEscolar/$codigoUe");
      if (response.statusCode == 200) {
        var ue = DadosUE.fromJson(response.data);
        return ue;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      GetIt.I.get<SentryClient>().captureException(exception: e);
      return null;
    }
  }
}
