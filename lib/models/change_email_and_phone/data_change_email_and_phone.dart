import '../../dtos/validacao_erro_dto.dart';

class DataChangeEmailAndPhone {
  bool ok = false;
  List<String>? erros;
  ValidacaoErros? validacaoErros;
  String token = "";

  DataChangeEmailAndPhone({this.ok = false, this.erros, this.validacaoErros});

  DataChangeEmailAndPhone.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'] != null ? json['erros'].cast<String>() : null;
    validacaoErros = json['validacaoErros'] != null ? new ValidacaoErros.fromJson(json['validacaoErros']) : null;
    token = json['data']['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['erros'] = this.erros;
    if (this.validacaoErros != null) {
      data['validacaoErros'] = this.validacaoErros?.toJson();
    }
    data['data']['token'] = this.token;
    return data;
  }
}
