import 'package:sme_app_aluno/models/frequency/frequencias_por_bimestre.dart';
import 'package:sme_app_aluno/models/index.dart';

class CurricularComponent {
  String anoLetivo;
  String codigoUe;
  String nomeUe;
  String codigoTurma;
  String nomeTurma;
  String alunoCodigo;
  int codigoComponenteCurricular;
  String componenteCurricular;
  List<EstudanteFrequenciaModel> frequencias;

  CurricularComponent(
      {this.anoLetivo,
      this.codigoUe,
      this.nomeUe,
      this.codigoTurma,
      this.nomeTurma,
      this.alunoCodigo,
      this.codigoComponenteCurricular,
      this.componenteCurricular,
      this.frequencias});

  CurricularComponent.fromJson(Map<String, dynamic> json) {
    anoLetivo = json['anoLetivo'];
    codigoUe = json['codigoUe'];
    nomeUe = json['nomeUe'];
    codigoTurma = json['codigoTurma'];
    nomeTurma = json['nomeTurma'];
    alunoCodigo = json['alunoCodigo'];
    codigoComponenteCurricular = json['codigoComponenteCurricular'];
    componenteCurricular = json['componenteCurricular'];
    if (json['frequenciasPorBimestre'] != null) {
      frequencias = new List<EstudanteFrequenciaModel>();
      json['frequenciasPorBimestre'].forEach((v) {
        frequencias.add(new EstudanteFrequenciaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anoLetivo'] = this.anoLetivo;
    data['codigoUe'] = this.codigoUe;
    data['nomeUe'] = this.nomeUe;
    data['codigoTurma'] = this.codigoTurma;
    data['nomeTurma'] = this.nomeTurma;
    data['alunoCodigo'] = this.alunoCodigo;
    data['codigoComponenteCurricular'] = this.codigoComponenteCurricular;
    data['componenteCurricular'] = this.componenteCurricular;
    return data;
  }
}
