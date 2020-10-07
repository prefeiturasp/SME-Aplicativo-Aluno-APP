class Event {
  String nome;
  String descricao;
  String dataInicio;
  String dataFim;
  int tipoEvento;
  int anoLetivo;

  Event(
      {this.nome,
      this.descricao,
      this.dataInicio,
      this.dataFim,
      this.tipoEvento,
      this.anoLetivo});

  Event.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    dataInicio = json['dataInicio'];
    dataFim = json['dataFim'];
    tipoEvento = json['tipoEvento'];
    anoLetivo = json['anoLetivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['dataInicio'] = this.dataInicio;
    data['dataFim'] = this.dataFim;
    data['tipoEvento'] = this.tipoEvento;
    data['anoLetivo'] = this.anoLetivo;
    return data;
  }
}
