import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../dtos/componente_curricular.dto.dart';
import '../models/message/group.dart';
import '../repositories/index.dart';
import '../services/group_messages.service.dart';
import '../stores/index.dart';

class EstudanteController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _groupMessageService = GroupMessageService();
  final _estudanteRepository = GetIt.I.get<EstudanteRepository>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();

  void subscribeGroupIdToFirebase() {
    _estudanteStore.gruposEstudantes.asMap().forEach((index, element) {
      _firebaseMessaging.subscribeToTopic('MODALIDADE-${element.codigoGrupo}');
      _groupMessageService.create(Group(codigo: 'MODALIDADE-${element.codigoGrupo}'));

      element.estudantes.asMap().forEach((index, estudante) {
        _firebaseMessaging.subscribeToTopic('TE-${estudante.codigoTipoEscola}');
        _groupMessageService.create(Group(codigo: 'TE-${estudante.codigoTipoEscola}'));

        _firebaseMessaging.subscribeToTopic('MODALIDADE-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}');
        _groupMessageService
            .create(Group(codigo: 'MODALIDADE-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}'));

        _firebaseMessaging.subscribeToTopic('DRE-${estudante.codigoDre}');
        _groupMessageService.create(Group(codigo: 'DRE-${estudante.codigoDre}'));
        log('DRE-${estudante.codigoDre}');

        _firebaseMessaging.subscribeToTopic('DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}');
        _groupMessageService.create(Group(codigo: 'DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}'));
        log('DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}');

        _firebaseMessaging.subscribeToTopic('UE-${estudante.codigoEscola}');
        _groupMessageService.create(Group(codigo: 'UE-${estudante.codigoEscola}'));
        log('UE-${estudante.codigoEscola}');

        _firebaseMessaging.subscribeToTopic('UE-${estudante.codigoEscola}-TE-${estudante.codigoTipoEscola}');
        _groupMessageService.create(Group(codigo: 'UE-${estudante.codigoEscola}-TE-${estudante.codigoTipoEscola}'));
        log('UE-${estudante.codigoEscola}-TE-${estudante.codigoTipoEscola}');

        _firebaseMessaging.subscribeToTopic('UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}');
        _groupMessageService.create(Group(codigo: 'UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}'));
        log('UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}');

        _firebaseMessaging.subscribeToTopic(
          'UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}',
        );
        _groupMessageService.create(
          Group(codigo: 'UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}'),
        );
        log('UE-${estudante.codigoEscola}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}');

        _firebaseMessaging.subscribeToTopic('TUR-${estudante.codigoTurma}');
        _groupMessageService.create(Group(codigo: 'TUR-${estudante.codigoTurma}'));
        log('TUR-${estudante.codigoTurma}');

        _firebaseMessaging.subscribeToTopic('ALU-${estudante.codigoEol}');
        _groupMessageService.create(Group(codigo: 'ALU-${estudante.codigoEol}'));
        log('ALU-${estudante.codigoEol}');

        _firebaseMessaging.subscribeToTopic('SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}');
        _groupMessageService
            .create(Group(codigo: 'SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}'));
        log('SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}');

        _firebaseMessaging.subscribeToTopic(
          'SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}',
        );
        _groupMessageService.create(
          Group(
            codigo:
                'SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}',
          ),
        );
        log('SERIERESUMIDA-${estudante.serieResumida}-MOD-${element.codigoGrupo}-TE-${estudante.codigoTipoEscola}');

        _firebaseMessaging.subscribeToTopic('SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}');
        _groupMessageService
            .create(Group(codigo: 'SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}'));
        log('SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}');

        _firebaseMessaging.subscribeToTopic(
          'SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}',
        );
        _groupMessageService.create(
          Group(
            codigo:
                'SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}',
          ),
        );
        log('SERIERESUMIDA-${estudante.serieResumida}-DRE-${estudante.codigoDre}-TE-${estudante.codigoTipoEscola}');
      });
    });
  }

  Future<void> obterEstudantes() async {
    try {
      _estudanteStore.carregando = true;
      final data = await _estudanteRepository.obterEstudantes();
      _estudanteStore.carregarGrupos(data.data);
      subscribeGroupIdToFirebase();
      _estudanteStore.carregando = false;
      _estudanteStore.erroCarregar = false;
    } on Exception {
      _estudanteStore.carregando = false;
      _estudanteStore.erroCarregar = true;
    }
  }

  Future<List<int>> obterBimestresDisponiveisParaVisualizacao(String turmaCodigo) async {
    _estudanteStore.carregando = true;
    final data = await _estudanteRepository.obterBimestresDisponiveisParaVisualizacao(turmaCodigo);
    _estudanteStore.carregando = false;
    return data;
  }

  Future<List<ComponenteCurricularDTO>> obterComponentesCurriculares(
    List<int> bimestres,
    String codigoUe,
    String codigoTurma,
    String alunoCodigo,
  ) async {
    _estudanteStore.carregando = true;
    final data = await _estudanteRepository.obterComponentesCurriculares(bimestres, codigoUe, codigoTurma, alunoCodigo);
    _estudanteStore.carregando = false;
    return data;
  }
}
