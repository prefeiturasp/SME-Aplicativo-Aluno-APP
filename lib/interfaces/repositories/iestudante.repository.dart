import '../../models/student/data_student.dart';

abstract class IEstudanteRepository {
  Future<DataStudent> fetchStudents(String cpf, int id, String token);
}
