import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

import '../dtos/componente_curricular.dto.dart';
import '../models/student/data_student.dart';
import '../services/index.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class EstudanteRepository {
  final _api = GetIt.I.get<ApiService>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();
  final url = AppConfigReader.getApiHost();

  Future<Either<List<String>, DataStudent>> obterEstudantes() async {
    try {
      final response = await _api.dio.get('/Aluno?cpf=${_usuarioStore.cpf}');

      if (response.statusCode == 200) {
        final dataEstudents = DataStudent.fromMap(response.data);
        return Right(dataEstudents);
      } else if (response.statusCode == 408) {
        return Right(DataStudent(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()], data: []));
      } else {
        final dataError = DataStudent.fromJson(response.data);
        GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Estudantes - EstudanteRepository.obterEstudantes() ${response.data}');
        return Right(dataError);
      }
    } 
    on DioException catch (ex, stacktrace) {
      final List<String> listaErros = [];
      GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Estudantes EstudanteRepository.obterEstudantes() $ex $stacktrace $url');
      final Response<dynamic>? err = ex.response;
      final List<String> erros = err?.data['erros'] != null ? List<String>.from(err!.data['erros']) : ['Não foi possível carregar a lista de estudantes no momento $url'];

      if (erros.isNotEmpty) {
        listaErros.addAll(erros);
      }
      return Left(listaErros);
    }
    catch (e, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Estudantes EstudanteRepository.obterEstudantes() $e $stacktrace');
      return Left(['Não foi possível carregar a lista de estudantes no momento $url']);
    }
  }

  Future<List<ComponenteCurricularDTO>> obterComponentesCurriculares(List<int> bimestres, String codigoUe, String codigoTurma, String alunoCodigo) async {
    try {
      final bimestresJoin = bimestres.join('&bimestres=');
      if (bimestresJoin.isEmpty) {
        return List<ComponenteCurricularDTO>() = [];
      }
      final response = await _api.dio.get('/Aluno/ues/$codigoUe/turmas/$codigoTurma/alunos/$alunoCodigo/componentes-curriculares?bimestres=$bimestresJoin');

      if (response.statusCode == 200) {
        final retorno = (response.data as List).map((x) => ComponenteCurricularDTO.fromJson(x)).toList();
        return retorno;
      } else {
        return [];
      }
    } catch (e, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Bimestres disponíveis EstudanteRepository.obterComponentesCurriculares() $e $stacktrace');
      return List<ComponenteCurricularDTO>() = [];
    }
  }

  Future<Either<List<String>, List<int>>> obterBimestresDisponiveisParaVisualizacao(String turmaCodigo) async {
    try {
      final url = '/Aluno/turmas/$turmaCodigo/boletins/liberacoes/bimestres';
      final response = await _api.dio.get(url);

      if (response.statusCode == 200) {
        final bimestres = response.data;
        return Right(bimestres.cast<int>());
      } else {
        GetIt.I.get<SentryClient>().captureException(response);
        return Left(['Erro ao carregar lista de Bimestres']);
      }
    } on DioException catch (ex, stacktrace) {
      final List<String> listaErros = [];
      GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Bimestres disponíveis obterBimestresDisponiveisParaVisualizacao $ex $stacktrace');
      final Response<dynamic>? err = ex.response;
      final List<String> erros = err?.data['erros'] != null ? List<String>.from(err!.data['erros']) : [];

      if (erros.isNotEmpty) {
        listaErros.addAll(erros);
      }
      return Left(listaErros);
    } on Exception catch (ex, stacktrace) {
      GetIt.I.get<SentryClient>().captureException('Erro ao carregar lista de Bimestres disponíveis obterBimestresDisponiveisParaVisualizacao $ex $stacktrace');

      return Left(['Erro ao carregar lista de Bimestres']);
    }
  }
}
