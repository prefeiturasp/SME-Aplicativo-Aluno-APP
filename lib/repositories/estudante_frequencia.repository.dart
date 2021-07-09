import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/dtos/estudante_frequencia_global.dto.dart';
import 'package:sme_app_aluno/models/estudante_frequencia.model.dart';
import 'package:sme_app_aluno/models/frequency/frequency.dart';
import 'package:sme_app_aluno/services/index.dart';
import 'package:sme_app_aluno/stores/index.dart';

class EstudanteFrequenciaRepository {
  final _api = GetIt.I.get<ApiService>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<Frequency> fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  ) async {
    try {
      final response = await _api.dio.get(
          "/Aluno/frequencia?AnoLetivo=$anoLetivo&CodigoUe=$codigoUe&CodigoTurma=$codigoTurma&CodigoAluno=$codigoAluno");

      if (response.statusCode == 200) {
        final frequency = Frequency.fromJson(response.data);
        return frequency;
      } else {
        print("Deu ruim");
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  Future<List<EstudanteFrequenciaModel>> fetchCurricularComponent(
      anoLetivo,
      codigoUE,
      String codigoTurma,
      String codigoAluno,
      String codigoComponenteCurricular,
      List<int> bimestres) async {
    try {
      var bimestresJoin = bimestres.join("&bimestres=");
      final response = await _api.dio.get(
          "/Aluno/frequencia/turmas/$codigoTurma/alunos/$codigoAluno/componentes-curriculares/$codigoComponenteCurricular?bimestres=$bimestresJoin");

//${AppConfigReader.getApiHost()}/Aluno/frequencia/componente-curricular?AnoLetivo=$anoLetivo&CodigoUe=$codigoUE&CodigoTurma=$codigoTurma&CodigoAluno=$codigoAluno&CodigoComponenteCurricular=$codigoComponenteCurricular",

      if (response.statusCode == 200) {
        var retorno = (response.data as List)
            .map((x) => EstudanteFrequenciaModel.fromJson(x))
            .toList();
        return retorno;
      } else {
        print("Erro ao obter a frequencia do aluno");
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  Future<EstudanteFrequenciaGlobalDTO> obterFrequenciaGlobal(
    String codigoTurma,
    String codigoAluno,
  ) async {
    try {
      final response = await _api.dio.get(
          "/Aluno/frequencia-global?turmaCodigo=$codigoTurma&alunoCodigo=$codigoAluno");
      if (response.statusCode == 200) {
        return EstudanteFrequenciaGlobalDTO.fromJson(response.data);
      } else {
        print("Erro ao obter a frequencia do aluno");
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
