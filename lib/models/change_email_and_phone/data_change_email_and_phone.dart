class DataChangeEmailAndPhone {
  bool? ok;
  List<String>? erros;
  ValidacaoErros? validacaoErros;
  String token = "";

  DataChangeEmailAndPhone({this.ok, this.erros, this.validacaoErros});

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

class ValidacaoErros {
  List<String>? additionalProp1;
  List<String>? additionalProp2;
  List<String>? additionalProp3;

  ValidacaoErros({this.additionalProp1, this.additionalProp2, this.additionalProp3});

  ValidacaoErros.fromJson(Map<String, dynamic> json) {
    additionalProp1 = json['additionalProp1'].cast<String>();
    additionalProp2 = json['additionalProp2'].cast<String>();
    additionalProp3 = json['additionalProp3'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additionalProp1'] = this.additionalProp1;
    data['additionalProp2'] = this.additionalProp2;
    data['additionalProp3'] = this.additionalProp3;
    return data;
  }
}
