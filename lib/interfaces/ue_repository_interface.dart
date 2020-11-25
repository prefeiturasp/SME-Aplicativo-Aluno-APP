import 'package:sme_app_aluno/models/ue/data_ue.dart';

abstract class IUERepository {
  Future<DadosUE> fetchUE(String codigoUe, int id);
}
