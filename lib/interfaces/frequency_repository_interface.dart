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
    dynamic anoLetivo,
    dynamic codigoUE,
    dynamic codigoTurma,
    dynamic codigoAluno,
    dynamic codigoComponenteCurricular,
  );
}
