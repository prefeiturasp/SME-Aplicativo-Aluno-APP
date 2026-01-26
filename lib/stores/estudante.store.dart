import 'package:mobx/mobx.dart';

import '../models/index.dart';

part 'estudante.store.g.dart';

class EstudanteStore = EstudanteStoreBase with _$EstudanteStore;

abstract class EstudanteStoreBase with Store {
  @observable
  bool carregando = false;

  @observable
  bool erroCarregar = false;

  @observable
  List<String> mensagensErro = [];

  @observable
  List<GrupoEstudanteModel> gruposEstudantes = [];

  @action
  void carregarGrupos(List<GrupoEstudanteModel> grupos) {
    gruposEstudantes = grupos;
  }
}
