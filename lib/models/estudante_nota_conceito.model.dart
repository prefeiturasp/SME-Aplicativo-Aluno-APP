class EstudanteNotaConceitoModel {
  int id;
  int conselhoClasseNotaId;
  int bimestre;
  int componenteCurricularCodigo;
  String componenteCurricularNome;
  int conceitoId;
  double nota;
  String corDaNota;
  String notaConceito;

  EstudanteNotaConceitoModel(
      {this.id,
      this.conselhoClasseNotaId,
      this.bimestre,
      this.componenteCurricularCodigo,
      this.conceitoId,
      this.nota,
      this.componenteCurricularNome,
      this.notaConceito});

  EstudanteNotaConceitoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conselhoClasseNotaId = json['conselhoClasseNotaId'];
    bimestre = json['bimestre'];
    corDaNota = json['corDaNota'];
    componenteCurricularCodigo = json['componenteCurricularCodigo'];
    componenteCurricularNome = json['componenteCurricularNome'];
    conceitoId = json['conceitoId'];
    nota = json['nota'];
    notaConceito = json['notaConceito'];
  }
}
