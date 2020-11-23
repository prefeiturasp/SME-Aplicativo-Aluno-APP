class ComponentesCurricularesDoAluno {
  int codigoComponenteCurricular;
  String descricaoComponenteCurricular;

  ComponentesCurricularesDoAluno({
    this.codigoComponenteCurricular,
    this.descricaoComponenteCurricular,
  });

  ComponentesCurricularesDoAluno.fromJson(Map<String, dynamic> json) {
    codigoComponenteCurricular = json['codigoComponenteCurricular'];
    descricaoComponenteCurricular = json['descricaoComponenteCurricular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoComponenteCurricular'] = this.codigoComponenteCurricular;
    data['descricaoComponenteCurricular'] = this.descricaoComponenteCurricular;
    return data;
  }
}
