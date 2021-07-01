import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/dtos/componente_curricular_nota.dto.dart';
import 'package:sme_app_aluno/models/index.dart';
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
  }

  @action
  fetchNotes(int anoLetivo, int bimestre, String codigoUe, String codigoTurma,
      String alunoCodigo) async {
    loading = true;

    if (bimestre == 1) {
      bUm = await _listNotesRepository.fetchListNotes(
          anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo);

      listNotesUm = ObservableList<Note>.of(
          bUm != null ? bUm.notasPorComponenteCurricular : []);

      if (listNotesUm != null && listNotesUm.isNotEmpty) {
        if (tamanho == null) {
          tamanho = listNotesUm.length;
        }
      }
    } else if (bimestre == 2) {
      bDois = await _listNotesRepository.fetchListNotes(
          anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo);

      listNotesDois = ObservableList<Note>.of(
          bDois != null ? bDois.notasPorComponenteCurricular : []);

      if (listNotesDois != null && listNotesDois.isNotEmpty) {
        if (tamanho == null) {
          tamanho = listNotesDois.length;
        }
      }
    } else if (bimestre == 3) {
      bTres = await _listNotesRepository.fetchListNotes(
          anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo);

      listNotesTres = ObservableList<Note>.of(
          bTres != null ? bTres.notasPorComponenteCurricular : []);

      if (listNotesTres != null && listNotesTres.isNotEmpty) {
        if (tamanho == null) {
          tamanho = listNotesTres.length;
        }
      }
    } else if (bimestre == 4) {
      bQuatro = await _listNotesRepository.fetchListNotes(
          anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo);

      listNotesQuatro = ObservableList<Note>.of(
          bQuatro != null ? bQuatro.notasPorComponenteCurricular : []);

      if (listNotesQuatro != null && listNotesQuatro.isNotEmpty) {
        if (tamanho == null) {
          tamanho = listNotesQuatro.length;
        }
      }
    } else {
      bFinal = await _listNotesRepository.fetchListNotes(
          anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo);

      listNotesFinal = ObservableList<Note>.of(
          bFinal != null ? bFinal.notasPorComponenteCurricular : []);

      if (listNotesFinal != null && listNotesFinal.isNotEmpty) {
        if (tamanho == null) {
          tamanho = listNotesFinal.length;
        }
      }
    }

    loading = false;
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
