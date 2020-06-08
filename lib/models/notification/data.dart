class Data {
  String titulo;
  String mensagem;
  int id;
  int grupo;

  Data({this.titulo, this.mensagem, this.id, this.grupo});

  Data.fromJson(Map<String, dynamic> json) {
    titulo = json['Titulo'];
    mensagem = json['Mensagem'];
    id = json['Id'];
    grupo = json['Grupo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Titulo'] = this.titulo;
    data['Mensagem'] = this.mensagem;
    data['Id'] = this.id;
    data['Grupo'] = this.grupo;
    return data;
  }
}
