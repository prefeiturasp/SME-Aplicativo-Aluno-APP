import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/terms/term.dart';
import 'package:sme_app_aluno/repositories/terms_repository.dart';
part 'terms.controller.g.dart';

class TermsController = _TermsControllerBase with _$TermsController;

abstract class _TermsControllerBase with Store {
  TermsRepository _termsRepository;

  _TermsControllerBase() {
    _termsRepository = TermsRepository();
  }

  @observable
  Term term;

  @observable
  bool loading = false;

  @observable
  bool isTerm = false;

  @action
  fetchTermo(String cpf) async {
    loading = true;
    term = await _termsRepository.fetchTerms(cpf);
    loading = false;
  }

  @action
  fetchTermoCurrentUser() async {
    loading = true;
    term = await _termsRepository.fetchTermsCurrentUser();
    loading = false;
  }

  @action
  registerTerms(int termoDeUsoId, String cpf, String device, String ip,
      double versao) async {
    loading = true;
    await _termsRepository.registerTerms(termoDeUsoId, cpf, device, ip, versao);
    loading = false;
  }
}
