import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/repositories/student_repository.dart';
part 'students.controller.g.dart';

class StudentsController = _StudentsControllerBase with _$StudentsController;

abstract class _StudentsControllerBase with Store {
  StudentRepository _studentRepository;

  _StudentsControllerBase() {
    _studentRepository = StudentRepository();
  }

  @observable
  DataStudent dataEstudent;

  @observable
  bool isLoading = false;

  @action
  loadingStudents(String cpf, String token) async {
    isLoading = true;
    dataEstudent = await _studentRepository.fetchStudents(cpf, token);
    isLoading = false;
  }
}
