// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../dtos/validacao_erro_dto.dart';

class Data {
  bool ok = false;
  List<String> erros = [];
  ValidacaoErros validacaoErros = ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []);
  Data({
    required this.ok,
    required this.erros,
    required this.validacaoErros,
  });

  Data.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    validacaoErros = json['validacaoErros'] != null
        ? ValidacaoErros.fromJson(json['validacaoErros'])
        : ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []);
    erros = json['erros'].cast<String>();
  }
}
