class EstudanteFrequenciaModel {
  int bimestre;
  String codigoAluno;
  String componenteCurricularId;
  int numeroFaltasNaoCompensadas;
  int periodoEscolarId;
  int totalAulas;
  int totalAusencias;
  int totalCompensacoes;
  String turmaId;
  String corDaFrequencia;
  double percentualFrequencia;
  double percentualFrequenciaFinal;

  EstudanteFrequenciaModel(
      {this.bimestre,
      this.codigoAluno,
      this.componenteCurricularId,
      this.numeroFaltasNaoCompensadas,
      this.percentualFrequencia,
      this.periodoEscolarId,
      this.totalAulas,
      this.totalAusencias,
      this.totalCompensacoes,
      this.turmaId,
      this.corDaFrequencia,
      this.percentualFrequenciaFinal});

  EstudanteFrequenciaModel.fromJson(Map<String, dynamic> json) {
    bimestre = json['bimestre'];
    codigoAluno = json['codigoAluno'];
    componenteCurricularId = json['disciplinaId'];
    numeroFaltasNaoCompensadas = json['numeroFaltasNaoCompensadas'];
    percentualFrequencia = json['percentualFrequencia'];
    periodoEscolarId = json['periodoEscolarId'];
    totalAulas = json['totalAulas'];
    totalAusencias = json['totalAusencias'];
    totalCompensacoes = json['totalCompensacoes'];
    turmaId = json['turmaId'];
    corDaFrequencia = json['corDaFrequencia'];
    percentualFrequenciaFinal = json['percentualFrequenciaFinal'];
  }
}
