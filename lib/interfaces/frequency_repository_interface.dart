import '../models/frequency/curricular_component.dart';
import '../models/frequency/frequency.dart';

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
