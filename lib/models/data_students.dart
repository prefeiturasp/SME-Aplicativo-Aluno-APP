import 'package:sme_app_aluno/models/student.dart';

class DataStudents {
  String descricaoTipoEscola;
  int codigoTipoEscola;
  List<Student> student;

  DataStudents({this.descricaoTipoEscola, this.codigoTipoEscola, this.student});

  DataStudents.fromJson(Map<String, dynamic> json) {
    descricaoTipoEscola = json['descricaoTipoEscola'];
    codigoTipoEscola = json['codigoTipoEscola'];
    if (json['alunos'] != null) {
      student = new List<Student>();
      json['alunos'].forEach((v) {
        student.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricaoTipoEscola'] = this.descricaoTipoEscola;
    data['codigoTipoEscola'] = this.codigoTipoEscola;
    if (this.student != null) {
      data['alunos'] = this.student.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
