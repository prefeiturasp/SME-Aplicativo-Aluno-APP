import 'package:sme_app_aluno/models/grupo_estudante.model.dart';

class DataStudent {
  bool ok;
  List<String> erros;
  List<GrupoEstudanteModel> data;

  DataStudent({this.ok, this.erros, this.data});

  DataStudent.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'].cast<String>();
    if (json['data'] != null) {
      data = new List<GrupoEstudanteModel>();
      json['data'].forEach((v) {
        data.add(new GrupoEstudanteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['erros'] = this.erros;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
