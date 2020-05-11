import 'package:sme_app_aluno/models/message/grupo.dart';

class Message {
  int id;
  String mensagem;
  String titulo;
  List<Grupo> grupos;
  String dataEnvio;
  String dataExpiracao;
  String criadoEm;
  String criadoPor;
  String alteradoEm;
  String alteradoPor;
  bool mensagemVisualizada;

  Message(
      {this.id,
      this.mensagem,
      this.titulo,
      this.grupos,
      this.dataEnvio,
      this.dataExpiracao,
      this.criadoEm,
      this.criadoPor,
      this.alteradoEm,
      this.alteradoPor,
      this.mensagemVisualizada});

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
    dataExpiracao = json['dataExpiracao'];
    criadoEm = json['criadoEm'];
    criadoPor = json['criadoPor'];
    alteradoEm = json['alteradoEm'];
    alteradoPor = json['alteradoPor'];
    mensagemVisualizada = json['mensagemVisualizada'];
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
    data['dataExpiracao'] = this.dataExpiracao;
    data['criadoEm'] = this.criadoEm;
    data['criadoPor'] = this.criadoPor;
    data['alteradoEm'] = this.alteradoEm;
    data['alteradoPor'] = this.alteradoPor;
    data['mensagemVisualizada'] = this.mensagemVisualizada;
    return data;
  }
}
