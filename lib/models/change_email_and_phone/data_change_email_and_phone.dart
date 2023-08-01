import '../../dtos/validacao_erro_dto.dart';

class DataChangeEmailAndPhone {
  bool ok = false;
  List<String>? erros;
  ValidacaoErros? validacaoErros;
  String token = '';

  DataChangeEmailAndPhone({this.ok = false, this.erros, this.validacaoErros});

  DataChangeEmailAndPhone.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'] != null ? json['erros'].cast<String>() : [];
    validacaoErros = json['validacaoErros'] != null ? ValidacaoErros.fromJson(json['validacaoErros']) : null;
    token = json['data']['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    data['erros'] = erros;
    if (validacaoErros != null) {
      data['validacaoErros'] = validacaoErros?.toJson();
    }
    data['data']['token'] = token;
    return data;
  }
}
