abstract class IBoletimRepository {
  Future<bool> solicitarBoletim({
    String dreCodigo,
    String ueCodigo,
    int semestre,
    String turmaCodigo,
    int anoLetivo,
    int modalidadeCodigo,
    int modelo,
    String alunoCodigo,
  });
}
