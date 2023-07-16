import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/dtos/componente_curricular_nota.dto.dart';
import 'package:sme_app_aluno/models/note/list_notes.dart';
import 'package:sme_app_aluno/models/note/note.dart';
import 'package:sme_app_aluno/repositories/index.dart';

part 'estudante_notas.controller.g.dart';

class EstudanteNotasController = EstudanteNotasControllerBase with _$EstudanteNotasController;

abstract class EstudanteNotasControllerBase with Store {
  late EstudanteNotasRepository _listNotesRepository;

  EstudanteNotasControllerBase() {
    this._listNotesRepository = EstudanteNotasRepository();
  }

  @observable
  late ListNotes bUm;

  @observable
  late ListNotes bDois;

  @observable
  late ListNotes bTres;

  @observable
  late ListNotes bQuatro;

  @observable
  late ListNotes bFinal;

  @observable
  late ObservableList<Note> listNotesUm;

  @observable
  late ObservableList<Note> listNotesDois;

  @observable
  late ObservableList<Note> listNotesTres;

  @observable
  late ObservableList<Note> listNotesQuatro;

  @observable
  late ObservableList<Note> listNotesFinal;

  @observable
  late ObservableList<ComponenteCurricularNotaDTO> componentesCurricularesNotasConceitos;

  @observable
  var tamanho;

  @observable
  bool loading = false;

  @action
  limparNotas() {
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
  obterNotasConceito(List<int> bimestres, String codigoUe, String codigoTurma, String alunoCodigo) async {
    loading = true;
    var retorno = await _listNotesRepository.obterNotasConceitos(codigoUe, codigoTurma, alunoCodigo, bimestres);

    var componentes = retorno.map((element) => element.componenteCurricularCodigo).toSet().toList();
    List<ComponenteCurricularNotaDTO> novaLista = [];
    for (var i = 0; i < componentes.length; i++) {
      var componenteCurricular = retorno.firstWhere((element) => element.componenteCurricularCodigo == componentes[i]);

      novaLista.add(new ComponenteCurricularNotaDTO(
          componenteCurricularId: componentes[i],
          componenteCurricularNome: componenteCurricular.componenteCurricularNome,
          notasConceitos: retorno.where((element) => element.componenteCurricularCodigo == componentes[i]).toList()));
    }

    componentesCurricularesNotasConceitos = ObservableList<ComponenteCurricularNotaDTO>.of(novaLista);
    loading = false;
  }
}
