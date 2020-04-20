import 'package:sme_app_aluno/models/student.dart';

abstract class IStudentsRepository {
  Future<List<Student>> fetchStudents(String cpf, String token);
}
