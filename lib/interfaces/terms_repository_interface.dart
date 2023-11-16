abstract class ITermsRepository {
  // Future<DataStudent> fetchStudents(String cpf, int id);
  Future<dynamic> fetchTerms(String cpf);
  Future<dynamic> fetchTermsCurrentUser();
  Future<bool> registerTerms(
      int termoDeUsoId, String cpf, String device, String ip, double versao,);
}
