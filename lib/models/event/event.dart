class Event {
  String nome;
  String descricao;
  String diaSemana;
  String dataInicio;
  String dataFim;
  int tipoEvento;
  int anoLetivo;
  String componenteCurricular;

  Event({
    this.nome,
    this.descricao,
    this.diaSemana,
    this.dataInicio,
    this.dataFim,
    this.tipoEvento,
    this.anoLetivo,
    this.componenteCurricular,
  });

  Event.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    diaSemana = json['diaSemana'];
    dataInicio = json['dataInicio'];
    dataFim = json['dataFim'];
    tipoEvento = json['tipoEvento'];
    anoLetivo = json['anoLetivo'];
    componenteCurricular = json['componenteCurricular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['diaSemana'] = this.diaSemana;
    data['dataInicio'] = this.dataInicio;
    data['dataFim'] = this.dataFim;
    data['tipoEvento'] = this.tipoEvento;
    data['anoLetivo'] = this.anoLetivo;
    data['componenteCurricular'] = this.componenteCurricular;
    return data;
  }
}
