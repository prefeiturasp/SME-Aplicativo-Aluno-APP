import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/dtos/estudante_frequencia_global.dto.dart';
import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/frequency/frequency.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/repositories/estudante_frequencia.repository.dart';

part 'estudante_frequencia.controller.g.dart';

class EstudanteFrequenciaController = _EstudanteFrequenciaControllerBase
    with _$EstudanteFrequenciaController;

abstract class _EstudanteFrequenciaControllerBase with Store {
  EstudanteFrequenciaRepository _estudanteFrequenciaRepository;

  _EstudanteFrequenciaControllerBase() {
    _estudanteFrequenciaRepository = EstudanteFrequenciaRepository();
  }

  @observable
  Frequency frequency;

  @observable
  EstudanteFrequenciaGlobalDTO frequencia;

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
  fetchCurricularComponent(
      int anoLetivo,
      String codigoUE,
      String codigoTurma,
      String codigoAluno,
      String codigoComponenteCurricular,
      List<int> bimestres) async {
    loadingCurricularComponent = true;
    var frequencias =
        await _estudanteFrequenciaRepository.fetchCurricularComponent(
            anoLetivo,
            codigoUE,
            codigoTurma,
            codigoAluno,
            codigoComponenteCurricular,
            bimestres);
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
      List<int> bimestres) async {
    loadingCurricularComponent = true;
    var frequencias =
        await _estudanteFrequenciaRepository.fetchCurricularComponent(
            anoLetivo,
            codigoUE,
            codigoTurma,
            codigoAluno,
            codigoComponenteCurricular,
            bimestres);
    loadingCurricularComponent = false;
    return frequencias;
  }

  @action
  obterFrequenciaGlobal(String codigoTurma, String codigoAluno) async {
    loadingCurricularComponent = true;
    frequencia = await _estudanteFrequenciaRepository.obterFrequenciaGlobal(
      codigoTurma,
      codigoAluno,
    );
    loadingCurricularComponent = false;
  }
}
