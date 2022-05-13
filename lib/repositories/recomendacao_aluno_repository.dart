import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/dtos/recomendacao_aluno.dto.dart';
import 'package:sme_app_aluno/interfaces/recomendacoes_aluno_interface.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class RecomendacaoAlunoRepository implements IRecomendacaoAluno {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  @override
  Future<RecomendacaoAlunoDto> obterRecomendacaoAluno(
    String codigoAluno,
    String codigoTurma,
    int anoLetivo,
    int modalidade,
    int semestre,
  ) async {
    var recomendacao = RecomendacaoAlunoDto();
    var url =
        "${AppConfigReader.getApiHost()}/Aluno/recomendacao-aluno?codigoAluno=$codigoAluno&codigoTurma=$codigoTurma&anoLetivo=$anoLetivo&semestre=$semestre&modalidade=$modalidade";
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        Map result = json.decode(response.body);
        return RecomendacaoAlunoDto.fromJson(result);
      } else {
        recomendacao.erro = false;
        recomendacao.mensagemAlerta = "Erro ao obter a recomendação do aluno";
        return recomendacao;
      }
    } catch (e) {
      print('$e');
      recomendacao.erro = true;
      recomendacao.mensagemAlerta = "Erro ao obter a recomendação do aluno";
      return recomendacao;
    }
  }
}
