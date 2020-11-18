import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/note/list_notes.dart';
import 'package:sme_app_aluno/models/note/note.dart';
import 'package:sme_app_aluno/repositories/list_notes_repository.dart';

part 'list_notes.controller.g.dart';

class ListNotesController = _ListNotesControllerBase with _$ListNotesController;

abstract class _ListNotesControllerBase with Store {
  ListNotesRepository _listNotesRepository;

  _ListNotesControllerBase() {
    _listNotesRepository = ListNotesRepository();
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
  var tamanho;

  @observable
  bool loading = false;

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
}
