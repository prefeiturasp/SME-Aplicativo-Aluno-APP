import 'package:sme_app_aluno/models/frequency/ausencias.dart';

class FrequenciasPorBimestre {
  int bimestre;
  int quantidadeAulas;
  int quantidadeFaltas;
  int quantidadeCompensacoes;
  String corDaFrequencia;
  double frequencia;
  List<Ausencias> ausencias;

  FrequenciasPorBimestre(
      {this.bimestre,
      this.quantidadeAulas,
      this.quantidadeFaltas,
      this.quantidadeCompensacoes,
      this.corDaFrequencia,
      this.frequencia,
      this.ausencias});

  FrequenciasPorBimestre.fromJson(Map<String, dynamic> json) {
    bimestre = json['bimestre'];
    quantidadeAulas = json['quantidadeAulas'];
    quantidadeFaltas = json['quantidadeFaltas'];
    quantidadeCompensacoes = json['quantidadeCompensacoes'];
    corDaFrequencia = json['corDaFrequencia'];
    frequencia = json['frequencia'];
    if (json['ausencias'] != null) {
      ausencias = new List<Ausencias>();
      json['ausencias'].forEach((v) {
        ausencias.add(new Ausencias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bimestre'] = this.bimestre;
    data['quantidadeAulas'] = this.quantidadeAulas;
    data['quantidadeFaltas'] = this.quantidadeFaltas;
    data['quantidadeCompensacoes'] = this.quantidadeCompensacoes;
    data['corDaFrequencia'] = this.corDaFrequencia;
    data['frequencia'] = this.frequencia;
    if (this.ausencias != null) {
      data['ausencias'] = this.ausencias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
