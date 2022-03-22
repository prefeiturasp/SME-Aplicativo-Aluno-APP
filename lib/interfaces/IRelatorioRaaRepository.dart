abstract class IRelatorioRaaRepository {
  Future<bool> solicitarRelatorioRaa({
    String dreCodigo,
    String ueCodigo,
    int semestre,
    String turmaCodigo,
    int anoLetivo,
    int modalidadeCodigo,
    String alunoCodigo,
  });
}
