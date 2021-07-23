class EstudanteModel {
  int codigoEol;
  String nome;
  String nomeSocial;
  String escola;
  int codigoTipoEscola;
  String descricaoTipoEscola;
  String siglaDre;
  String turma;
  String situacaoMatricula;
  String dataNascimento;
  String dataSituacaoMatricula;
  String codigoDre;
  String codigoEscola;
  int codigoTurma;
  String serieResumida;

  EstudanteModel({
    this.codigoEol,
    this.nome,
    this.nomeSocial,
    this.escola,
    this.codigoTipoEscola,
    this.descricaoTipoEscola,
    this.siglaDre,
    this.codigoDre,
    this.turma,
    this.situacaoMatricula,
    this.dataNascimento,
    this.dataSituacaoMatricula,
    this.codigoEscola,
    this.codigoTurma,
    this.serieResumida,
  });

  EstudanteModel.fromJson(Map<String, dynamic> json) {
    codigoEol = json['codigoEol'];
    nome = json['nome'];
    nomeSocial = json['nomeSocial'];
    escola = json['escola'];
    codigoTipoEscola = json['codigoTipoEscola'];
    descricaoTipoEscola = json['descricaoTipoEscola'];
    codigoDre = json['codigoDre'] ?? "";
    siglaDre = json['siglaDre'];
    turma = json['turma'];
    situacaoMatricula = json['situacaoMatricula'];
    dataNascimento = json['dataNascimento'];
    dataSituacaoMatricula = json['dataSituacaoMatricula'];
    codigoEscola = json['codigoEscola'] ?? "";
    codigoTurma = json['codigoTurma'] ?? 0;
    serieResumida = json['serieResumida'];
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
    data['situacaoMatricula'] = this.situacaoMatricula;
    data['dataNascimento'] = this.dataNascimento;
    data['dataSituacaoMatricula'] = this.dataSituacaoMatricula;
    data['codigoEscola'] = this.codigoEscola;
    data['codigoTurma'] = this.codigoTurma;
    data['serieResumida'] = this.serieResumida;
    return data;
  }
}
