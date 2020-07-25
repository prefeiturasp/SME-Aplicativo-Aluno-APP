import 'package:sme_app_aluno/models/message/grupo.dart';

class Message {
  int id;
  String mensagem;
  String titulo;
  List<Grupo> grupos;
  String dataEnvio;
  String criadoEm;
  bool mensagemVisualizada;
  String categoriaNotificacao;

  Message(
      {this.id,
      this.mensagem,
      this.titulo,
      this.grupos,
      this.dataEnvio,
      this.criadoEm,
      this.mensagemVisualizada,
      this.categoriaNotificacao});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mensagem = json['mensagem'];
    titulo = json['titulo'];
    if (json['grupos'] != null) {
      grupos = new List<Grupo>();
      json['grupos'].forEach((v) {
        grupos.add(new Grupo.fromJson(v));
      });
    }
    dataEnvio = json['dataEnvio'];
    criadoEm = json['criadoEm'];
    mensagemVisualizada = json['mensagemVisualizada'];
    categoriaNotificacao = json['categoriaNotificacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mensagem'] = this.mensagem;
    data['titulo'] = this.titulo;
    if (this.grupos != null) {
      data['grupos'] = this.grupos.map((v) => v.toJson()).toList();
    }
    data['dataEnvio'] = this.dataEnvio;
    data['criadoEm'] = this.criadoEm;
    data['mensagemVisualizada'] = this.mensagemVisualizada;
    data['categoriaNotificacao'] = this.categoriaNotificacao;
    return data;
  }
}
