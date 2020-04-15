import 'package:sme_app_aluno/models/data_students.dart';

abstract class IStudentsRepository {
  Future<List<DataStudents>> fetchStudents(String cpf, String token);
}
