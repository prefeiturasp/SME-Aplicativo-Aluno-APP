class Message {
  int id;
  String mensagem;
  String titulo;
  String dataEnvio;
  String criadoEm;
  bool mensagemVisualizada;
  String categoriaNotificacao;
  int codigoEOL;

  Message(
      {this.id,
      this.mensagem,
      this.titulo,
      this.dataEnvio,
      this.criadoEm,
      this.mensagemVisualizada,
      this.categoriaNotificacao,
      this.codigoEOL});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mensagem = json['mensagem'];
    titulo = json['titulo'];
    dataEnvio = json['dataEnvio'];
    criadoEm = json['criadoEm'];
    mensagemVisualizada = json['mensagemVisualizada'];
    categoriaNotificacao = json['categoriaNotificacao'];
    codigoEOL = json['CodigoEOL'] ?? null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mensagem': mensagem,
      'titulo': titulo,
      'dataEnvio': dataEnvio,
      'criadoEm': criadoEm,
      'mensagemVisualizada': mensagemVisualizada ? 1 : 0,
      'categoriaNotificacao': categoriaNotificacao,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mensagem'] = this.mensagem;
    data['titulo'] = this.titulo;
    data['dataEnvio'] = this.dataEnvio;
    data['criadoEm'] = this.criadoEm;
    data['mensagemVisualizada'] = this.mensagemVisualizada;
    data['categoriaNotificacao'] = this.categoriaNotificacao;
    return data;
  }
}
