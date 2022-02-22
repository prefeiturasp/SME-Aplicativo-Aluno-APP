import 'package:flutter/material.dart';

class OutroServicoModel {
  String categoria;
  String titulo;
  String descricao;
  String urlSite;
  String icone;
  bool destaque;

  OutroServicoModel({
    @required this.categoria,
    @required this.titulo,
    @required this.descricao,
    @required this.urlSite,
    @required this.icone,
    @required this.destaque,
  });

  OutroServicoModel.fromJson(Map<String, dynamic> json) {
    categoria = json['categoria'] ?? "";
    titulo = json['titulo'] ?? "";
    descricao = json['descricao'] ?? "";
    urlSite = json['urlSite'] ?? "";
    icone = json['icone'] ?? "";
    destaque = json['destaque'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoria'] = this.categoria;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['urlSite'] = this.urlSite;
    data['icone'] = this.icone;
    data['destaque'] = this.destaque;
    return data;
  }
}
