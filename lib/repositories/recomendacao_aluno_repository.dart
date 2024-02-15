import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import '../dtos/recomendacao_aluno.dto.dart';
import '../interfaces/recomendacoes_aluno_interface.dart';
import '../stores/usuario.store.dart';
import '../utils/app_config_reader.dart';

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
    final recomendacao = RecomendacaoAlunoDto();
    final url = Uri.parse(
      '${AppConfigReader.getApiHost()}/Aluno/recomendacao-aluno?codigoAluno=$codigoAluno&codigoTurma=$codigoTurma&anoLetivo=$anoLetivo&semestre=$semestre&modalidade=$modalidade',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return RecomendacaoAlunoDto.fromJson(response.body);
      } else {
        recomendacao.erro = false;
        recomendacao.mensagemAlerta = 'Erro ao obter a recomendação do aluno';
        return recomendacao;
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('$e');
      recomendacao.erro = true;
      recomendacao.mensagemAlerta = 'Erro ao obter a recomendação do aluno';
      return recomendacao;
    }
  }
}
