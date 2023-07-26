import 'package:mobx/mobx.dart';

import '../dtos/componente_curricular_nota.dto.dart';
import '../models/note/list_notes.dart';
import '../models/note/note.dart';
import '../repositories/index.dart';

part 'estudante_notas.controller.g.dart';

class EstudanteNotasController = EstudanteNotasControllerBase with _$EstudanteNotasController;

abstract class EstudanteNotasControllerBase with Store {
  final EstudanteNotasRepository _listNotesRepository = EstudanteNotasRepository();

  @observable
  ListNotes? bUm;

  @observable
  ListNotes? bDois;

  @observable
  ListNotes? bTres;

  @observable
  ListNotes? bQuatro;

  @observable
  ListNotes? bFinal;

  @observable
  ObservableList<Note>? listNotesUm;

  @observable
  ObservableList<Note>? listNotesDois;

  @observable
  ObservableList<Note>? listNotesTres;

  @observable
  ObservableList<Note>? listNotesQuatro;

  @observable
  ObservableList<Note>? listNotesFinal;

  @observable
  ObservableList<ComponenteCurricularNotaDTO> componentesCurricularesNotasConceitos =
      ObservableList<ComponenteCurricularNotaDTO>();

  @observable
  var tamanho;

  @observable
  bool loading = false;

  @action
  void limparNotas() {
    bUm = ListNotes(notasPorComponenteCurricular: []);
    bDois = ListNotes(notasPorComponenteCurricular: []);
    bTres = ListNotes(notasPorComponenteCurricular: []);
    bQuatro = ListNotes(notasPorComponenteCurricular: []);
    bFinal = ListNotes(notasPorComponenteCurricular: []);
    listNotesUm = ObservableList<Note>();
    listNotesDois = ObservableList<Note>();
    listNotesTres = ObservableList<Note>();
    listNotesQuatro = ObservableList<Note>();
    listNotesFinal = ObservableList<Note>();
    componentesCurricularesNotasConceitos = ObservableList<ComponenteCurricularNotaDTO>();
  }

  @action
  Future<void> obterNotasConceito(List<int> bimestres, String codigoUe, String codigoTurma, String alunoCodigo) async {
    loading = true;
    final retorno = await _listNotesRepository.obterNotasConceitos(codigoUe, codigoTurma, alunoCodigo, bimestres);

    final componentes = retorno.map((element) => element.componenteCurricularCodigo).toSet().toList();
    final List<ComponenteCurricularNotaDTO> novaLista = [];
    for (var i = 0; i < componentes.length; i++) {
      final componenteCurricular =
          retorno.firstWhere((element) => element.componenteCurricularCodigo == componentes[i]);

      novaLista.add(
        ComponenteCurricularNotaDTO(
          componenteCurricularId: componentes[i],
          componenteCurricularNome: componenteCurricular.componenteCurricularNome,
          notasConceitos: retorno.where((element) => element.componenteCurricularCodigo == componentes[i]).toList(),
        ),
      );
    }

    componentesCurricularesNotasConceitos = ObservableList<ComponenteCurricularNotaDTO>.of(novaLista);
    loading = false;
  }
}
