import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/models/message/group.dart';
import 'package:sme_app_aluno/repositories/index.dart';
import 'package:sme_app_aluno/services/group_messages.service.dart';
import 'package:sme_app_aluno/stores/index.dart';

class EstudanteController {
  FirebaseMessaging _firebaseMessaging;
  final _groupMessageService = GroupMessageService();
  final _estudanteRepository = GetIt.I.get<EstudanteRepository>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();

  EstudanteController() {
    _firebaseMessaging = FirebaseMessaging();
  }

  subscribeGroupIdToFirebase() {
    if (_estudanteStore.gruposEstudantes != null) {
      _estudanteStore.gruposEstudantes.asMap().forEach((index, element) {
        _firebaseMessaging.subscribeToTopic("Grupo-${element.codigoGrupo}");
        _groupMessageService
            .create(Group(codigo: "Grupo-${element.codigoGrupo}"));

        element.estudantes.asMap().forEach((index, student) {
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

          _firebaseMessaging.subscribeToTopic(
              "SERIERESUMIDA-${student.serieResumida}-MOD-${element.codigoGrupo}");
          _groupMessageService.create(Group(
              codigo:
                  "SERIERESUMIDA-${student.serieResumida}-MOD-${element.codigoGrupo}"));
          print(
              "SERIERESUMIDA-${student.serieResumida}-MOD-${element.codigoGrupo}");

          _firebaseMessaging.subscribeToTopic(
              "SERIERESUMIDA-${student.serieResumida}-DRE-${student.codigoDre}");
          _groupMessageService.create(Group(
              codigo:
                  "SERIERESUMIDA-${student.serieResumida}-DRE-${student.codigoDre}"));
          print(
              "SERIERESUMIDA-${student.serieResumida}-DRE-${student.codigoDre}");
        });
      });
    }
  }

  obterEstudantes() async {
    _estudanteStore.carregando = true;
    var data = await _estudanteRepository.obterEstudantes();
    _estudanteStore.carregarGrupos(data.data);
    subscribeGroupIdToFirebase();
    _estudanteStore.carregando = false;
  }

  Future<List<int>> obterBimestresDisponiveisParaVisualizacao(
      String turmaCodigo) async {
    _estudanteStore.carregando = true;
    var data = await _estudanteRepository
        .obterBimestresDisponiveisParaVisualizacao(turmaCodigo);
    _estudanteStore.carregando = false;
    return data;
  }
}
