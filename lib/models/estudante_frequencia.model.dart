import 'dart:convert';

class EstudanteFrequenciaModel {
  final int bimestre;
  final String codigoAluno;
  final String componenteCurricularId;
  final int numeroFaltasNaoCompensadas;
  final int? periodoEscolarId;
  final int totalAulas;
  final int totalAusencias;
  final int totalCompensacoes;
  final String turmaId;
  final String corDaFrequencia;
  final double percentualFrequencia;
  final double percentualFrequenciaFinal;
  EstudanteFrequenciaModel({
    required this.bimestre,
    required this.codigoAluno,
    required this.componenteCurricularId,
    required this.numeroFaltasNaoCompensadas,
    required this.periodoEscolarId,
    required this.totalAulas,
    required this.totalAusencias,
    required this.totalCompensacoes,
    required this.turmaId,
    required this.corDaFrequencia,
    required this.percentualFrequencia,
    required this.percentualFrequenciaFinal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bimestre': bimestre,
      'codigoAluno': codigoAluno,
      'componenteCurricularId': componenteCurricularId,
      'numeroFaltasNaoCompensadas': numeroFaltasNaoCompensadas,
      'periodoEscolarId': periodoEscolarId,
      'totalAulas': totalAulas,
      'totalAusencias': totalAusencias,
      'totalCompensacoes': totalCompensacoes,
      'turmaId': turmaId,
      'corDaFrequencia': corDaFrequencia,
      'percentualFrequencia': percentualFrequencia,
      'percentualFrequenciaFinal': percentualFrequenciaFinal,
    };
  }

  factory EstudanteFrequenciaModel.fromMap(Map<String, dynamic> map) {
    return EstudanteFrequenciaModel(
      bimestre: map['bimestre'] as int,
      codigoAluno: map['codigoAluno'] ?? '',
      componenteCurricularId: map['disciplinaId'] ?? '',
      numeroFaltasNaoCompensadas: map['numeroFaltasNaoCompensadas'] as int,
      periodoEscolarId: map['periodoEscolarId'],
      totalAulas: map['totalAulas'] as int,
      totalAusencias: map['totalAusencias'] as int,
      totalCompensacoes: map['totalCompensacoes'] as int,
      turmaId: map['turmaId'] ?? '',
      corDaFrequencia: map['corDaFrequencia'] ?? '',
      percentualFrequencia: map['percentualFrequencia'] as double,
      percentualFrequenciaFinal: map['percentualFrequenciaFinal'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstudanteFrequenciaModel.fromJson(String source) =>
      EstudanteFrequenciaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
