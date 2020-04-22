class Message {
  int id;
  String mensagem;
  String titulo;
  String grupo;
  DateTime dataEnvio;
  DateTime dataExpiracao;
  DateTime criadoEm;
  String criadoPor;
  DateTime alteradoEm;
  String alteradoPor;

  Message({
    this.id, 
    this.mensagem,
    this.titulo,
    this.grupo,
    this.dataEnvio,
    this.dataExpiracao,
    this.criadoEm,
    this.criadoPor,
    this.alteradoEm,
    this.alteradoPor
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    mensagem = json["mensagem"];
    titulo = json["titulo"];
    grupo = json["grupo"];
    dataEnvio = DateTime.tryParse(json["dataEnvio"]);
    dataExpiracao = DateTime.tryParse(json["dataExpiracao"]);
    criadoEm = DateTime.tryParse(json["criadoEm"]);
    criadoPor = json["criadoPor"];
    alteradoEm = json["alteradoEm"] != null ? DateTime.tryParse(json["alteradoEm"]) : null;
    alteradoPor = json["alteradoPor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json["id"] = id;
    json["mensagem"] = mensagem;
    json["titulo"] = titulo;
    json["grupo"] = grupo;
    json["dataEnvio"] = dataEnvio;
    json["dataExpiracao"] = dataExpiracao;
    json["criadoEm"] = criadoEm;
    json["criadoPor"] = criadoPor;
    json["alteradoEm"] = alteradoEm;
    json["alteradoPor"] = alteradoPor;
    return json;
  }

  static List<Message> fromJsonList(List<Map<String, dynamic>> json) => 
    json.map<Message>((i) => Message.fromJson(i)).toList();
}
