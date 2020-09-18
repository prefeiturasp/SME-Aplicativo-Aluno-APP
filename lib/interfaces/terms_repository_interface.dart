

import 'package:sme_app_aluno/models/terms/term.dart';

abstract class ITermsRepository {
  // Future<DataStudent> fetchStudents(String cpf, int id);
  Future<dynamic> fetchTerms(String cpf);
  Future<bool> registerTerms(int termoDeUsoId, String usuario, String device, String ip, double versao);
}