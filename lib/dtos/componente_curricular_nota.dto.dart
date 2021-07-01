import 'package:sme_app_aluno/models/index.dart';

class ComponenteCurricularNotaDTO {
  String componenteCurricularNome;
  int componenteCurricularId;
  List<EstudanteNotaConceitoModel> notasConceitos;

  ComponenteCurricularNotaDTO(
      {this.componenteCurricularNome,
      this.componenteCurricularId,
      this.notasConceitos});
}
