import 'dart:convert';

import 'package:sme_app_aluno/interfaces/student_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/data_students.dart';
import 'package:sme_app_aluno/utils/api.dart';

class StudentRepository implements IStudentsRepository {
  @override
  Future<List<DataStudents>> fetchStudents(String cpf, String token) async {
    try {
      List<DataStudents> listDataStudents = List();
      final response = await http.post("${Api.HOST}/Aluno?cpf=$cpf",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final jsonConteudo = decodeJson["data"];

        jsonConteudo.forEach(
            (item) => listDataStudents.add(DataStudents.fromJson(item)));

        return listDataStudents;
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
