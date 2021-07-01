import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/index.dart';

part 'estudante.store.g.dart';

class EstudanteStore = _EstudanteStoreBase with _$EstudanteStore;

abstract class _EstudanteStoreBase with Store {
  @observable
  bool carregando = false;

  @observable
  List<GrupoEstudanteModel> gruposEstudantes;

  @action
  void carregarGrupos(List<GrupoEstudanteModel> grupos) {
    gruposEstudantes = grupos;
  }
}
