import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/message/group.dart';
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/repositories/student_repository.dart';
import 'package:sme_app_aluno/services/group_messages.service.dart';
part 'students.controller.g.dart';

class StudentsController = _StudentsControllerBase with _$StudentsController;

abstract class _StudentsControllerBase with Store {
  StudentRepository _studentRepository;
  FirebaseMessaging _firebaseMessaging;
  final _groupMessageService = GroupMessageService();

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
        _groupMessageService
            .create(Group(codigo: "Grupo-${element.codigoGrupo}"));

        element.students.asMap().forEach((index, student) {
          _firebaseMessaging.subscribeToTopic("DRE-${student.codigoDre}");
          _groupMessageService
              .create(Group(codigo: "DRE-${student.codigoDre}"));
          print("DRE-${student.codigoDre}");

          _firebaseMessaging.subscribeToTopic("UE-${student.codigoEscola}");
          _groupMessageService
              .create(Group(codigo: "UE-${student.codigoEscola}"));
          print("UE-${student.codigoEscola}");

          _firebaseMessaging.subscribeToTopic(
              "UE-${student.codigoEscola}-MOD-${element.codigoGrupo}");
          _groupMessageService.create(Group(
              codigo: "UE-${student.codigoEscola}-MOD-${element.codigoGrupo}"));
          print("UE-${student.codigoEscola}-MOD-${element.codigoGrupo}");

          _firebaseMessaging.subscribeToTopic("TUR-${student.codigoTurma}");
          _groupMessageService
              .create(Group(codigo: "TUR-${student.codigoTurma}"));
          print("TUR-${student.codigoTurma}");

          _firebaseMessaging.subscribeToTopic("ALU-${student.codigoEol}");
          _groupMessageService
              .create(Group(codigo: "ALU-${student.codigoEol}"));
          print("ALU-${student.codigoEol}");
        });
      });
    }
  }

  @action
  loadingStudents(String cpf, int id) async {
    isLoading = true;
    dataEstudent = await _studentRepository.fetchStudents(cpf, id);
    subscribeGroupIdToFirebase();
    isLoading = false;
  }
}
