class Term {
  int id;
  String termosDeUso;
  String politicaDePrivacidade;
  double versao;

  Term({
    this.id,
    this.termosDeUso,
    this.politicaDePrivacidade,
    this.versao,
  });

  Term.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termosDeUso = json['termosDeUso'];
    politicaDePrivacidade = json['politicaDePrivacidade'];
    versao = json['versao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['termosDeUso'] = this.termosDeUso;
    data['politicaDePrivacidade'] = this.politicaDePrivacidade;
    data['versao'] = this.versao;
    return data;
  }
}
