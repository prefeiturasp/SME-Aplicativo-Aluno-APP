// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ValidacaoErros {
  late List<String> additionalProp1;
  late List<String> additionalProp2;
  late List<String> additionalProp3;

  ValidacaoErros({required this.additionalProp1, required this.additionalProp2, required this.additionalProp3});

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
