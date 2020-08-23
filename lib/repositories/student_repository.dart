import 'dart:convert';

import 'package:sme_app_aluno/interfaces/student_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';

class StudentRepository implements IStudentsRepository {
  final UserService _userService = UserService();

  @override
  Future<DataStudent> fetchStudents(String cpf, int id) async {
    final User user = await _userService.find(id);
    try {
      final response = await http.post("${Api.HOST}/Aluno?cpf=$cpf",
          headers: {"Authorization": "Bearer ${user.token}"});

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final dataEstudents = DataStudent.fromJson(decodeJson);
        return dataEstudents;
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = DataStudent.fromJson(decodeError);
        return dataError;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Estudantes " + stacktrace.toString());
      return null;
    }
  }
}
