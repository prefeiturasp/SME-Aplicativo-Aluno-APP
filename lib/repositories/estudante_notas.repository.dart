import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/models/note/list_notes.dart';
import 'package:sme_app_aluno/services/index.dart';

class EstudanteNotasRepository {
  final _api = GetIt.I.get<ApiService>();

  Future<ListNotes> fetchListNotes(int anoLetivo, int bimestre, String codigoUe,
      String codigoTurma, String alunoCodigo) async {
    try {
      var response = await _api.dio.get(
          "/Aluno/notas?AnoLetivo=$anoLetivo&Bimestre=$bimestre&CodigoUe=$codigoUe&CodigoTurma=$codigoTurma&CodigoAluno=$alunoCodigo");
      if (response.statusCode == 200) {
        final data = ListNotes.fromJson(response.data);
        return data;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

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
      return null;
    }
  }
}
