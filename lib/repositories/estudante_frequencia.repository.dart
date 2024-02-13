import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

import '../dtos/estudante_frequencia_global.dto.dart';
import '../models/estudante_frequencia.model.dart';
import '../models/frequency/frequency.dart';
import '../services/index.dart';

class EstudanteFrequenciaRepository {
  final _api = GetIt.I.get<ApiService>();

  Future<Frequency> fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  ) async {
    try {
      final response = await _api.dio.get(
        '/Aluno/frequencia?AnoLetivo=$anoLetivo&CodigoUe=$codigoUe&CodigoTurma=$codigoTurma&CodigoAluno=$codigoAluno',
      );

      if (response.statusCode == 200) {
        final frequency = Frequency.fromJson(response.data);
        return frequency;
      } else {
        GetIt.I.get<SentryClient>().captureException('Erro ao obter a frequencia do aluno ${response.statusCode}');
        throw Exception(response.statusCode);
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException(e);
      throw Exception(e);
    }
  }

  Future<List<EstudanteFrequenciaModel>> fetchCurricularComponent(
    anoLetivo,
    codigoUE,
    String codigoTurma,
    String codigoAluno,
    String codigoComponenteCurricular,
    List<int> bimestres,
  ) async {
    try {
      final bimestresJoin = bimestres.join('&bimestres=');
      final response = await _api.dio.get(
        '/Aluno/frequencia/turmas/$codigoTurma/alunos/$codigoAluno/componentes-curriculares/$codigoComponenteCurricular?bimestres=$bimestresJoin',
      );

      if (response.statusCode == 200) {
        final retorno = (response.data as List).map((x) => EstudanteFrequenciaModel.fromMap(x)).toList();
        return retorno;
      } else {
        GetIt.I.get<SentryClient>().captureException('Erro ao obter a frequencia do aluno ${response.statusCode}');
        throw Exception(response.statusCode);
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException(e);
      throw Exception(e);
    }
  }

  Future<EstudanteFrequenciaGlobalDTO> obterFrequenciaGlobal(
    String codigoTurma,
    String codigoAluno,
  ) async {
    try {
      final response = await _api.dio.get('/Aluno/frequencia-global?turmaCodigo=$codigoTurma&alunoCodigo=$codigoAluno');
      if (response.statusCode == 200) {
        return EstudanteFrequenciaGlobalDTO.fromJson(response.data);
      } else {
        GetIt.I.get<SentryClient>().captureException('Erro ao obter a frequencia do aluno ${response.statusCode}');
        throw Exception(response.statusCode);
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException(e);
      throw Exception(e);
    }
  }
}
