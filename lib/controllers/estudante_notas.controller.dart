import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/dtos/componente_curricular_nota.dto.dart';
import 'package:sme_app_aluno/models/note/list_notes.dart';
import 'package:sme_app_aluno/models/note/note.dart';
import 'package:sme_app_aluno/repositories/index.dart';

part 'estudante_notas.controller.g.dart';

class EstudanteNotasController = _EstudanteNotasControllerBase
    with _$EstudanteNotasController;

abstract class _EstudanteNotasControllerBase with Store {
  EstudanteNotasRepository _listNotesRepository;

  _EstudanteNotasControllerBase() {
    _listNotesRepository = EstudanteNotasRepository();
  }

  @observable
  ListNotes bUm;

  @observable
  ListNotes bDois;

  @observable
  ListNotes bTres;

  @observable
  ListNotes bQuatro;

  @observable
  ListNotes bFinal;

  @observable
  ObservableList<Note> listNotesUm;

  @observable
  ObservableList<Note> listNotesDois;

  @observable
  ObservableList<Note> listNotesTres;

  @observable
  ObservableList<Note> listNotesQuatro;

  @observable
  ObservableList<Note> listNotesFinal;

  @observable
  ObservableList<ComponenteCurricularNotaDTO>
      componentesCurricularesNotasConceitos;

  @observable
  var tamanho;

  @observable
  bool loading = false;

  @action
  limparNotas() {
    bUm = null;
    bDois = null;
    bTres = null;
    bQuatro = null;
    bFinal = null;
    listNotesUm = null;
    listNotesDois = null;
    listNotesTres = null;
    listNotesQuatro = null;
    listNotesFinal = null;
    componentesCurricularesNotasConceitos = null;
  }

  @action
  obterNotasConceito(List<int> bimestres, String codigoUe, String codigoTurma,
      String alunoCodigo) async {
    loading = true;
    var retorno = await _listNotesRepository.obterNotasConceitos(
        codigoUe, codigoTurma, alunoCodigo, bimestres);

    var componentes = retorno
        .map((element) => element.componenteCurricularCodigo)
        .toSet()
        .toList();
    List<ComponenteCurricularNotaDTO> novaLista =
        new List<ComponenteCurricularNotaDTO>();
    for (var i = 0; i < componentes.length; i++) {
      var componenteCurricular = retorno.firstWhere(
          (element) => element.componenteCurricularCodigo == componentes[i],
          orElse: () => null);

      novaLista.add(new ComponenteCurricularNotaDTO(
          componenteCurricularId: componentes[i],
          componenteCurricularNome:
              componenteCurricular.componenteCurricularNome,
          notasConceitos: retorno
              .where((element) =>
                  element.componenteCurricularCodigo == componentes[i])
              .toList()));
    }

    componentesCurricularesNotasConceitos =
        ObservableList<ComponenteCurricularNotaDTO>.of(novaLista);
    loading = false;
  }
}
