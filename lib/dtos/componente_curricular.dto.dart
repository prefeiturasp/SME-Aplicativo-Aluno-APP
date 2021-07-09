import 'package:sme_app_aluno/models/estudante_frequencia.model.dart';

class ComponenteCurricularDTO {
  String descricao;
  int codigo;
  bool expandido;
  List<EstudanteFrequenciaModel> frequencias;

  ComponenteCurricularDTO({this.descricao, this.codigo, this.frequencias});

  ComponenteCurricularDTO.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    codigo = json['codigo'];
    expandido = false;
  }
}
