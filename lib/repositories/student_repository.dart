import 'dart:convert';

import 'package:sme_app_aluno/interfaces/student_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/utils/api.dart';

class StudentRepository implements IStudentsRepository {
  @override
  Future<DataStudent> fetchStudents(String cpf, String token) async {
    try {
      final response = await http.post("${Api.HOST}/Aluno?cpf=$cpf",
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final dataEstudents = DataStudent.fromJson(decodeJson);

        return dataEstudents;
      } else {
        print("Erro ao carregar lista de Estudantes " +
            response.statusCode.toString());
        return null;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Estudantes " + stacktrace.toString());
      return null;
    }
  }
}
