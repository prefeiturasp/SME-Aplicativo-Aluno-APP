abstract class IBoletimRepository {
  Future<bool> solicitarBoletim({
    required String dreCodigo,
    required String ueCodigo,
    required int semestre,
    required String turmaCodigo,
    required int anoLetivo,
    required int modalidadeCodigo,
    required int modelo,
    required String alunoCodigo,
  });
}
