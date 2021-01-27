import 'package:sme_app_aluno/models/frequency/componentes_curriculares_do_aluno.dart';

class Frequency {
  String anoLetivo;
  String codigoUe;
  String codigoTurma;
  String alunoCodigo;
  int quantidadeAulas;
  int quantidadeFaltas;
  int quantidadeCompensacoes;
  double frequencia;
  String corDaFrequencia;
  List<ComponentesCurricularesDoAluno> componentesCurricularesDoAluno;

  Frequency({
    this.anoLetivo,
    this.codigoUe,
    this.codigoTurma,
    this.alunoCodigo,
    this.quantidadeAulas,
    this.quantidadeFaltas,
    this.quantidadeCompensacoes,
    this.frequencia,
    this.corDaFrequencia,
    this.componentesCurricularesDoAluno,
  });

  Frequency.fromJson(Map<String, dynamic> json) {
    anoLetivo = json['anoLetivo'];
    codigoUe = json['codigoUe'];
    codigoTurma = json['codigoTurma'];
    alunoCodigo = json['alunoCodigo'];
    quantidadeAulas = json['quantidadeAulas'];
    quantidadeFaltas = json['quantidadeFaltas'];
    quantidadeCompensacoes = json['quantidadeCompensacoes'];
    frequencia = json['frequencia'];
    corDaFrequencia = json['corDaFrequencia'];
    if (json['componentesCurricularesDoAluno'] != null) {
      componentesCurricularesDoAluno =
          new List<ComponentesCurricularesDoAluno>();
      json['componentesCurricularesDoAluno'].forEach((v) {
        componentesCurricularesDoAluno
            .add(new ComponentesCurricularesDoAluno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anoLetivo'] = this.anoLetivo;
    data['codigoUe'] = this.codigoUe;
    data['codigoTurma'] = this.codigoTurma;
    data['alunoCodigo'] = this.alunoCodigo;
    data['quantidadeAulas'] = this.quantidadeAulas;
    data['quantidadeFaltas'] = this.quantidadeFaltas;
    data['quantidadeCompensacoes'] = this.quantidadeCompensacoes;
    data['frequencia'] = this.frequencia;
    data['corDaFrequencia'] = this.corDaFrequencia;
    if (this.componentesCurricularesDoAluno != null) {
      data['componentesCurricularesDoAluno'] =
          this.componentesCurricularesDoAluno.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
