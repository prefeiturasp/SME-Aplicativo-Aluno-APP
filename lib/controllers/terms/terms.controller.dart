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
  bool termAcceted = false;

  @observable
  bool isTerm = false;

  @action
  fetchTermo(String cpf) async{
    loading = true;
    term = await _termsRepository.fetchTerms(cpf);
    loading = false;
  }

  @action
  fetchVerifyTerm(String cpf) async{
    loading = true;
    isTerm = await _termsRepository.fetchTerms(cpf) ? true : false;
    if(isTerm){
      fetchTermo(cpf);
    }
    loading = false;
  }

  @action
  registerTerms(int termoDeUsoId, String usuario, String device, String ip, double versao) async{
    loading = true;
    termAcceted = await _termsRepository.registerTerms(termoDeUsoId, usuario, device, ip, versao);
    loading = false;
  }

}