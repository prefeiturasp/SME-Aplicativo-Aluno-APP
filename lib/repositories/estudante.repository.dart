import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/dtos/componente_curricular.dto.dart';
import 'package:sme_app_aluno/models/student/data_student.dart';
import 'package:sme_app_aluno/services/index.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class EstudanteRepository {
  final _api = GetIt.I.get<ApiService>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();

  Future<DataStudent> obterEstudantes() async {
    try {
      final response = await _api.dio.get("/Aluno?cpf=${_usuarioStore.cpf}");

      if (response.statusCode == 200) {
        final dataEstudents = DataStudent.fromJson(response.data);
        return dataEstudents;
      } else if (response.statusCode == 408) {
        return DataStudent(
            ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var dataError = DataStudent.fromJson(response.data);
        return dataError;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Estudantes " + stacktrace.toString());
      return null;
    }
  }

  Future<List<ComponenteCurricularDTO>> obterComponentesCurriculares(
      List<int> bimestres,
      String codigoUe,
      String codigoTurma,
      String alunoCodigo) async {
    try {
      var bimestresJoin = bimestres.join("&bimestres=");
      final response = await _api.dio.get(
          "/Aluno/ues/$codigoUe/turmas/$codigoTurma/alunos/$alunoCodigo/componentes-curriculares?bimestres=$bimestresJoin");

      if (response.statusCode == 200) {
        var retorno = (response.data as List)
            .map((x) => ComponenteCurricularDTO.fromJson(x))
            .toList();
        return retorno;
      } else {
        return null;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Bimestres disponíveis " +
          stacktrace.toString());
      return null;
    }
  }

  Future<List<int>> obterBimestresDisponiveisParaVisualizacao(
      String turmaCodigo) async {
    try {
      final response = await _api.dio
          .get("/Aluno/turmas/$turmaCodigo/boletins/liberacoes/bimestres");

      if (response.statusCode == 200) {
        final bimestres = response.data;
        return bimestres.cast<int>();
      } else {
        return null;
      }
    } catch (e, stacktrace) {
      print("Erro ao carregar lista de Bimestres disponíveis " +
          stacktrace.toString());
      return null;
    }
  }
}
