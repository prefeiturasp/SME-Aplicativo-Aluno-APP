// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sme_app_aluno/models/frequency/ausencias.dart';

class FrequenciasPorBimestre {
  int bimestre;
  int quantidadeAulas;
  int quantidadeFaltas;
  int quantidadeCompensacoes;
  String corDaFrequencia;
  double frequencia;
  List<Ausencias> ausencias;
  FrequenciasPorBimestre({
    required this.bimestre,
    required this.quantidadeAulas,
    required this.quantidadeFaltas,
    required this.quantidadeCompensacoes,
    required this.corDaFrequencia,
    required this.frequencia,
    required this.ausencias,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bimestre': bimestre,
      'quantidadeAulas': quantidadeAulas,
      'quantidadeFaltas': quantidadeFaltas,
      'quantidadeCompensacoes': quantidadeCompensacoes,
      'corDaFrequencia': corDaFrequencia,
      'frequencia': frequencia,
      'ausencias': ausencias.map((x) => x.toMap()).toList(),
    };
  }

  factory FrequenciasPorBimestre.fromMap(Map<String, dynamic> map) {
    return FrequenciasPorBimestre(
      bimestre: map['bimestre'] as int,
      quantidadeAulas: map['quantidadeAulas'] as int,
      quantidadeFaltas: map['quantidadeFaltas'] as int,
      quantidadeCompensacoes: map['quantidadeCompensacoes'] as int,
      corDaFrequencia: map['corDaFrequencia'] as String,
      frequencia: map['frequencia'] as double,
      ausencias: List<Ausencias>.from(
        (map['ausencias'] as List<int>).map<Ausencias>(
          (x) => Ausencias.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FrequenciasPorBimestre.fromJson(String source) =>
      FrequenciasPorBimestre.fromMap(json.decode(source) as Map<String, dynamic>);
}
