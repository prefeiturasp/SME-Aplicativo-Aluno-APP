import 'package:sme_app_aluno/models/student/student.dart';

class Data {
  String grupo;
  List<Student> students;

  Data({this.grupo, this.students});

  Data.fromJson(Map<String, dynamic> json) {
    grupo = json['grupo'];
    if (json['alunos'] != null) {
      students = new List<Student>();
      json['alunos'].forEach((v) {
        students.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grupo'] = this.grupo;
    if (this.students != null) {
      data['alunos'] = this.students.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
