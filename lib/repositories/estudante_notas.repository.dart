import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/services/index.dart';

class EstudanteNotasRepository {
  final _api = GetIt.I.get<ApiService>();

  Future<List<EstudanteNotaConceitoModel>> obterNotasConceitos(String codigoUe,
      String codigoTurma, String alunoCodigo, List<int> bimestres) async {
    try {
      var bimestresJoin = bimestres.join("&bimestres=");
      var response = await _api.dio.get(
          "/Aluno/ues/$codigoUe/turmas/$codigoTurma/alunos/$alunoCodigo/notas-conceitos?bimestres=$bimestresJoin");
      if (response.statusCode == 200) {
        var retorno = (response.data as List)
            .map((x) => EstudanteNotaConceitoModel.fromJson(x))
            .toList();
        return retorno;
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
