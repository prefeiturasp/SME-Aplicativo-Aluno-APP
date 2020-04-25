class Message {
  int id;
  String mensagem;
  String titulo;
  String grupo;
  String dataEnvio;
  String dataExpiracao;
  String criadoEm;
  String criadoPor;
  String alteradoEm;
  String alteradoPor;

  Message(
      {this.id,
      this.mensagem,
      this.titulo,
      this.grupo,
      this.dataEnvio,
      this.dataExpiracao,
      this.criadoEm,
      this.criadoPor,
      this.alteradoEm,
      this.alteradoPor});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mensagem = json['mensagem'];
    titulo = json['titulo'];
    grupo = json['grupo'];
    dataEnvio = json['dataEnvio'];
    dataExpiracao = json['dataExpiracao'];
    criadoEm = json['criadoEm'];
    criadoPor = json['criadoPor'];
    alteradoEm = json['alteradoEm'];
    alteradoPor = json['alteradoPor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mensagem'] = this.mensagem;
    data['titulo'] = this.titulo;
    data['grupo'] = this.grupo;
    data['dataEnvio'] = this.dataEnvio;
    data['dataExpiracao'] = this.dataExpiracao;
    data['criadoEm'] = this.criadoEm;
    data['criadoPor'] = this.criadoPor;
    data['alteradoEm'] = this.alteradoEm;
    data['alteradoPor'] = this.alteradoPor;
    return data;
  }
}
