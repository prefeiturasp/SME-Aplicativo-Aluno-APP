import 'package:mobx/mobx.dart';
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
  bool loadingFrequency = false;

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
}
