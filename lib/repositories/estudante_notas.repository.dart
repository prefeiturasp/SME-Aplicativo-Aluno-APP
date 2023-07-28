import 'package:get_it/get_it.dart';
import '../models/index.dart';
import '../services/index.dart';
import 'dart:developer';

class EstudanteNotasRepository {
  final _api = GetIt.I.get<ApiService>();

  Future<List<EstudanteNotaConceitoModel>> obterNotasConceitos(
    String codigoUe,
    String codigoTurma,
    String alunoCodigo,
    List<int> bimestres,
  ) async {
    try {
      final bimestresJoin = bimestres.join('&bimestres=');
      final response = await _api.dio
          .get('/Aluno/ues/$codigoUe/turmas/$codigoTurma/alunos/$alunoCodigo/notas-conceitos?bimestres=$bimestresJoin');
      if (response.statusCode == 200) {
        final retorno = (response.data as List).map((x) => EstudanteNotaConceitoModel.fromMap(x)).toList();
        return retorno;
      } else {
        log('Erro ao obter dados EstudanteNotasRepository obterNotasConceitos ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Erro ao obter dados EstudanteNotasRepository obterNotasConceitos $e');
      return [];
    }
  }
}
