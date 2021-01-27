import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/frequency/frequency.dart';

abstract class IFrequencyRepository {
  Future<Frequency> fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  );

  Future<CurricularComponent> fetchCurricularComponent(
    anoLetivo,
    codigoUE,
    codigoTurma,
    codigoAluno,
    codigoComponenteCurricular,
  );
}
