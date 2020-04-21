class Student {
  int codigoEol;
  String nome;
  String nomeSocial;
  String escola;
  int codigoTipoEscola;
  String descricaoTipoEscola;
  String siglaDre;
  String turma;
  String dataNascimento;

  Student(
      {this.codigoEol,
      this.nome,
      this.nomeSocial,
      this.escola,
      this.codigoTipoEscola,
      this.descricaoTipoEscola,
      this.siglaDre,
      this.turma,
      this.dataNascimento});

  Student.fromJson(Map<String, dynamic> json) {
    codigoEol = json['codigoEol'];
    nome = json['nome'];
    nomeSocial = json['nomeSocial'];
    escola = json['escola'];
    codigoTipoEscola = json['codigoTipoEscola'];
    descricaoTipoEscola = json['descricaoTipoEscola'];
    siglaDre = json['siglaDre'];
    turma = json['turma'];
    dataNascimento = json["dataNascimento"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoEol'] = this.codigoEol;
    data['nome'] = this.nome;
    data['nomeSocial'] = this.nomeSocial;
    data['escola'] = this.escola;
    data['codigoTipoEscola'] = this.codigoTipoEscola;
    data['descricaoTipoEscola'] = this.descricaoTipoEscola;
    data['siglaDre'] = this.siglaDre;
    data['turma'] = this.turma;
    data["dataNascimento"] = this.dataNascimento;
    return data;
  }
}
