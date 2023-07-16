import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/ue/data_ue.dart';
import 'package:sme_app_aluno/repositories/ue.repository.dart';

part 'ue.controller.g.dart';

class UEController = UEControllerBase with _$UEController;

abstract class UEControllerBase with Store {
  final UERepository _ueRepository;

  UEControllerBase(this._ueRepository);

  @observable
  late DadosUE dadosUE;

  @observable
  bool isLoading = false;

  @action
  loadingUE(String codigoUe) async {
    isLoading = true;
    dadosUE = await _ueRepository.obterPorCodigo(codigoUe);
    isLoading = false;
  }
}
