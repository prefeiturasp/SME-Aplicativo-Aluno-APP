class ComponentesCurricularesDoAluno {
  int codigoComponenteCurricular;
  String descricaoComponenteCurricular;
  bool isExpanded;

  ComponentesCurricularesDoAluno(
      {this.codigoComponenteCurricular,
      this.descricaoComponenteCurricular,
      this.isExpanded});

  ComponentesCurricularesDoAluno.fromJson(Map<String, dynamic> json) {
    codigoComponenteCurricular = json['codigoComponenteCurricular'];
    descricaoComponenteCurricular = json['descricaoComponenteCurricular'];
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoComponenteCurricular'] = this.codigoComponenteCurricular;
    data['descricaoComponenteCurricular'] = this.descricaoComponenteCurricular;
    return data;
  }
}
