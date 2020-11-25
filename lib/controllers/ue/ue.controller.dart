import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/ue/data_ue.dart';
import 'package:sme_app_aluno/repositories/ue_repository.dart';

part 'ue.controller.g.dart';

class UEController = _UEControllerBase with _$UEController;

abstract class _UEControllerBase with Store {
  UERepository _ueRepository;

  _UEControllerBase() {
    _ueRepository = UERepository();
  }

  @observable
  DadosUE dadosUE;

  @observable
  bool isLoading = false;

  @action
  loadingUE(String codigoUe, int id) async {
    isLoading = true;
    dadosUE = await _ueRepository.fetchUE(codigoUe, id);
    isLoading = false;
  }
}
