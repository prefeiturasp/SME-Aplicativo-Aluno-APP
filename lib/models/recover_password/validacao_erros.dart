class ValidacaoErros {
  List<String> additionalProp1;
  List<String> additionalProp2;
  List<String> additionalProp3;

  ValidacaoErros(
      {this.additionalProp1, this.additionalProp2, this.additionalProp3});

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
