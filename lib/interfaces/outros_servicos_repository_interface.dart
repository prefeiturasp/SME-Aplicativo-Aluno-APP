import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';

abstract class IOutrosServicosRepository {
  Future<List<OutroServicoModel>> obterLinksPioritario();
  Future<List<OutroServicoModel>> obterTodosLinks();
  Future<bool> verificarSeRelatorioExiste(String codigoRelatorio);
}
