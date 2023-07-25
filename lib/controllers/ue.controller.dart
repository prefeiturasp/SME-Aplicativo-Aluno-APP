import 'package:mobx/mobx.dart';

import '../models/ue/data_ue.dart';
import '../repositories/ue.repository.dart';

part 'ue.controller.g.dart';

class UEController = UEControllerBase with _$UEController;

abstract class UEControllerBase with Store {
  final UERepository _ueRepository = UERepository();

  @observable
  DadosUE? dadosUE;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadingUE(String codigoUe) async {
    isLoading = true;
    dadosUE = await _ueRepository.obterPorCodigo(codigoUe);
    isLoading = false;
  }
}
