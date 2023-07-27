import 'package:mobx/mobx.dart';

import '../dtos/estudante_frequencia_global.dto.dart';
import '../models/frequency/curricular_component.dart';
import '../models/frequency/frequency.dart';
import '../models/index.dart';
import '../repositories/estudante_frequencia.repository.dart';

part 'estudante_frequencia.controller.g.dart';

class EstudanteFrequenciaController = EstudanteFrequenciaControllerBase with _$EstudanteFrequenciaController;

abstract class EstudanteFrequenciaControllerBase with Store {
  final EstudanteFrequenciaRepository _estudanteFrequenciaRepository = EstudanteFrequenciaRepository();

  @observable
  Frequency? frequency;

  @observable
  EstudanteFrequenciaGlobalDTO? frequencia;

  @observable
  CurricularComponent? curricularComponent;

  @observable
  bool loadingFrequency = false;

  @observable
  bool loadingCurricularComponent = false;

  @action
  void limpar() {
    frequency = null;
    frequencia = null;
    curricularComponent = null;
  }

  @action
  Future<void> showCard(int index) async {
    frequency?.componentesCurricularesDoAluno[index].isExpanded =
        frequency!.componentesCurricularesDoAluno[index].isExpanded;
  }

  @action
  Future<void> fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  ) async {
    loadingFrequency = true;
    frequency = await _estudanteFrequenciaRepository.fetchFrequency(
      anoLetivo,
      codigoUe,
      codigoTurma,
      codigoAluno,
      userId,
    );
    loadingFrequency = false;
  }

  @action
  Future<List<EstudanteFrequenciaModel>> fetchCurricularComponent(
    int anoLetivo,
    String codigoUE,
    String codigoTurma,
    String codigoAluno,
    String codigoComponenteCurricular,
    List<int> bimestres,
  ) async {
    loadingCurricularComponent = true;
    final frequencias = await _estudanteFrequenciaRepository.fetchCurricularComponent(
      anoLetivo,
      codigoUE,
      codigoTurma,
      codigoAluno,
      codigoComponenteCurricular,
      bimestres,
    );
    //curricularComponent =
    loadingCurricularComponent = false;
    return frequencias;
  }

  Future<List<EstudanteFrequenciaModel>> obterFrequenciasEstudante(
    int anoLetivo,
    String codigoUE,
    String codigoTurma,
    String codigoAluno,
    String codigoComponenteCurricular,
    List<int> bimestres,
  ) async {
    loadingCurricularComponent = true;
    final frequencias = await _estudanteFrequenciaRepository.fetchCurricularComponent(
      anoLetivo,
      codigoUE,
      codigoTurma,
      codigoAluno,
      codigoComponenteCurricular,
      bimestres,
    );
    loadingCurricularComponent = false;
    return frequencias;
  }

  @action
  Future<void> obterFrequenciaGlobal(String codigoTurma, String codigoAluno) async {
    loadingCurricularComponent = true;
    frequencia = await _estudanteFrequenciaRepository.obterFrequenciaGlobal(
      codigoTurma,
      codigoAluno,
    );
    loadingCurricularComponent = false;
  }
}
