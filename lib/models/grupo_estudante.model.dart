import 'package:sme_app_aluno/models/estudante.model.dart';

class GrupoEstudanteModel {
  String grupo;
  int codigoGrupo;
  List<EstudanteModel> estudantes;

  GrupoEstudanteModel({this.grupo, this.estudantes});

  GrupoEstudanteModel.fromJson(Map<String, dynamic> json) {
    grupo = json['grupo'];
    codigoGrupo = json['codigoGrupo'];
    if (json['alunos'] != null) {
      estudantes = new List<EstudanteModel>();
      json['alunos'].forEach((v) {
        estudantes.add(new EstudanteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grupo'] = this.grupo;
    data['codigoGrupo'] = this.codigoGrupo;
    if (this.estudantes != null) {
      data['alunos'] = this.estudantes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
