import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/repositories/student_repository.dart';
part 'students.controller.g.dart';

class StudentsController = _StudentsControllerBase with _$StudentsController;

abstract class _StudentsControllerBase with Store {
  StudentRepository _studentRepository;
  FirebaseMessaging _firebaseMessaging;

  _StudentsControllerBase() {
    _studentRepository = StudentRepository();
    _firebaseMessaging = FirebaseMessaging();
  }

  @observable
  DataStudent dataEstudent;

  @observable
  bool isLoading = false;

  @action
  subscribeGroupIdToFirebase() {
    if (dataEstudent.data != null) {
      dataEstudent.data.asMap().forEach((index, element) {
        _firebaseMessaging.subscribeToTopic("Grupo-${element.codigoGrupo}");
        print("Grupo-${element.codigoGrupo}");
        _firebaseMessaging
            .subscribeToTopic("DRE-${element.students[index].codigoDre}");
        print("DRE-${element.students[index].codigoDre}");
        _firebaseMessaging
            .subscribeToTopic("UE-${element.students[index].codigoEscola}");
        print("UE-${element.students[index].codigoEscola}");
        _firebaseMessaging.subscribeToTopic(
            "UE-${element.students[index].codigoEscola}-MOD-${element.codigoGrupo}");
        print(
            "UE-${element.students[index].codigoEscola}-MOD-${element.codigoGrupo}");
        _firebaseMessaging
            .subscribeToTopic("TUR-${element.students[index].codigoTurma}");
        _firebaseMessaging
            .subscribeToTopic("ALU-${element.students[index].codigoEol}");
        print("ALU-${element.students[index].codigoEol}");
      });
    }
  }

  @action
  loadingStudents(String cpf, String token) async {
    isLoading = true;
    dataEstudent = await _studentRepository.fetchStudents(cpf, token);
    subscribeGroupIdToFirebase();
    isLoading = false;
  }
}
