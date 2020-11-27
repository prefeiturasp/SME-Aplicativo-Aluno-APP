import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/frequency/frequency.dart';
import 'package:sme_app_aluno/repositories/frequency_repository.dart';

part 'frequency.controller.g.dart';

class FrequencyController = _FrequencyControllerBase with _$FrequencyController;

abstract class _FrequencyControllerBase with Store {
  FrequencyRepository _frequencyRepository;

  _FrequencyControllerBase() {
    _frequencyRepository = FrequencyRepository();
  }

  @observable
  Frequency frequency;

  @observable
  CurricularComponent curricularComponent;

  @observable
  bool loadingFrequency = false;

  @observable
  bool loadingCurricularComponent = false;

  @action
  Future<void> showCard(int index) async {
    frequency.componentesCurricularesDoAluno[index].isExpanded =
        !frequency.componentesCurricularesDoAluno[index].isExpanded;
  }

  @action
  fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  ) async {
    loadingFrequency = true;
    frequency = await _frequencyRepository.fetchFrequency(
      anoLetivo,
      codigoUe,
      codigoTurma,
      codigoAluno,
      userId,
    );
    loadingFrequency = false;
  }

  @action
  fetchCurricularComponent(
    int anoLetivo,
    String codigoUE,
    String codigoTurma,
    String codigoAluno,
    String codigoComponenteCurricular,
  ) async {
    loadingCurricularComponent = true;
    curricularComponent = await _frequencyRepository.fetchCurricularComponent(
      anoLetivo,
      codigoUE,
      codigoTurma,
      codigoAluno,
      codigoComponenteCurricular,
    );
    loadingCurricularComponent = false;
    return curricularComponent;
  }
}
