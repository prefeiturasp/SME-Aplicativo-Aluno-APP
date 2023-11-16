import '../dtos/recomendacao_aluno.dto.dart';

abstract class IRecomendacaoAluno {
  Future<RecomendacaoAlunoDto> obterRecomendacaoAluno(
    String codAluno,
    String codTurma,
    int anoLetivo,
    int modalidade,
    int semestre,
  );
}
