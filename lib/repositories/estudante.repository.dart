import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../dtos/componente_curricular.dto.dart';
import '../models/student/data_student.dart';
import '../services/index.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class EstudanteRepository {
  final _api = GetIt.I.get<ApiService>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<DataStudent> obterEstudantes() async {
    try {
      final response = await _api.dio.get('/Aluno?cpf=${_usuarioStore.cpf}');

      if (response.statusCode == 200) {
        final dataEstudents = DataStudent.fromMap(response.data);
        return dataEstudents;
      } else if (response.statusCode == 408) {
        log(AppConfigReader.getErrorMessageTimeOut());
        return DataStudent(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()], data: []);
      } else {
        final dataError = DataStudent.fromJson(response.data);
        log('Erro ao carregar lista de Estudantes - EstudanteRepository');
        return dataError;
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Estudantes EstudanteRepository $stacktrace');
      throw Exception(e);
    }
  }

  Future<List<ComponenteCurricularDTO>> obterComponentesCurriculares(
    List<int> bimestres,
    String codigoUe,
    String codigoTurma,
    String alunoCodigo,
  ) async {
    try {
      final bimestresJoin = bimestres.join('&bimestres=');
      final response = await _api.dio.get(
        '/Aluno/ues/$codigoUe/turmas/$codigoTurma/alunos/$alunoCodigo/componentes-curriculares?bimestres=$bimestresJoin',
      );

      if (response.statusCode == 200) {
        final retorno = (response.data as List).map((x) => ComponenteCurricularDTO.fromJson(x)).toList();
        return retorno;
      } else {
        return [];
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Bimestres disponíveis $stacktrace');
      throw Exception(e);
    }
  }

  Future<List<int>> obterBimestresDisponiveisParaVisualizacao(String turmaCodigo) async {
    try {
      final response = await _api.dio.get('/Aluno/turmas/$turmaCodigo/boletins/liberacoes/bimestres');

      if (response.statusCode == 200) {
        final bimestres = response.data;
        return bimestres.cast<int>();
      } else {
        return [];
      }
    } catch (e, stacktrace) {
      log('Erro ao carregar lista de Bimestres disponíveis $stacktrace');
      throw Exception(e);
    }
  }
}
