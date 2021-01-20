import 'package:sme_app_aluno/models/student/data_student.dart';

abstract class IStudentsRepository {
  Future<DataStudent> fetchStudents(String cpf, int id);
}
