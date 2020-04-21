import 'package:sme_app_aluno/models/student/student.dart';

class Data {
  String descricaoTipoEscola;
  int codigoTipoEscola;
  List<Student> students;

  Data({this.descricaoTipoEscola, this.codigoTipoEscola, this.students});

  Data.fromJson(Map<String, dynamic> json) {
    descricaoTipoEscola = json['descricaoTipoEscola'];
    codigoTipoEscola = json['codigoTipoEscola'];
    if (json['alunos'] != null) {
      students = new List<Student>();
      json['alunos'].forEach((v) {
        students.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricaoTipoEscola'] = this.descricaoTipoEscola;
    data['codigoTipoEscola'] = this.codigoTipoEscola;
    if (this.students != null) {
      data['alunos'] = this.students.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
