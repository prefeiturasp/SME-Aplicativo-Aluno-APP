// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'componentes_curriculares_do_aluno.dart';

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
    required this.anoLetivo,
    required this.codigoUe,
    required this.codigoTurma,
    required this.alunoCodigo,
    required this.quantidadeAulas,
    required this.quantidadeFaltas,
    required this.quantidadeCompensacoes,
    required this.frequencia,
    required this.corDaFrequencia,
    required this.componentesCurricularesDoAluno,
  });


  Frequency copyWith({
    String? anoLetivo,
    String? codigoUe,
    String? codigoTurma,
    String? alunoCodigo,
    int? quantidadeAulas,
    int? quantidadeFaltas,
    int? quantidadeCompensacoes,
    double? frequencia,
    String? corDaFrequencia,
    List<ComponentesCurricularesDoAluno>? componentesCurricularesDoAluno,
  }) {
    return Frequency(
      anoLetivo: anoLetivo ?? this.anoLetivo,
      codigoUe: codigoUe ?? this.codigoUe,
      codigoTurma: codigoTurma ?? this.codigoTurma,
      alunoCodigo: alunoCodigo ?? this.alunoCodigo,
      quantidadeAulas: quantidadeAulas ?? this.quantidadeAulas,
      quantidadeFaltas: quantidadeFaltas ?? this.quantidadeFaltas,
      quantidadeCompensacoes: quantidadeCompensacoes ?? this.quantidadeCompensacoes,
      frequencia: frequencia ?? this.frequencia,
      corDaFrequencia: corDaFrequencia ?? this.corDaFrequencia,
      componentesCurricularesDoAluno: componentesCurricularesDoAluno ?? this.componentesCurricularesDoAluno,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'anoLetivo': anoLetivo,
      'codigoUe': codigoUe,
      'codigoTurma': codigoTurma,
      'alunoCodigo': alunoCodigo,
      'quantidadeAulas': quantidadeAulas,
      'quantidadeFaltas': quantidadeFaltas,
      'quantidadeCompensacoes': quantidadeCompensacoes,
      'frequencia': frequencia,
      'corDaFrequencia': corDaFrequencia,
      'componentesCurricularesDoAluno': componentesCurricularesDoAluno.map((x) => x.toMap()).toList(),
    };
  }

  factory Frequency.fromMap(Map<String, dynamic> map) {
    return Frequency(
      anoLetivo: map['anoLetivo'] as String,
      codigoUe: map['codigoUe'] as String,
      codigoTurma: map['codigoTurma'] as String,
      alunoCodigo: map['alunoCodigo'] as String,
      quantidadeAulas: map['quantidadeAulas'] as int,
      quantidadeFaltas: map['quantidadeFaltas'] as int,
      quantidadeCompensacoes: map['quantidadeCompensacoes'] as int,
      frequencia: map['frequencia'] as double,
      corDaFrequencia: map['corDaFrequencia'] as String,
      componentesCurricularesDoAluno: List<ComponentesCurricularesDoAluno>.from((map['componentesCurricularesDoAluno'] as List<int>).map<ComponentesCurricularesDoAluno>((x) => ComponentesCurricularesDoAluno.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Frequency.fromJson(String source) => Frequency.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Frequency(anoLetivo: $anoLetivo, codigoUe: $codigoUe, codigoTurma: $codigoTurma, alunoCodigo: $alunoCodigo, quantidadeAulas: $quantidadeAulas, quantidadeFaltas: $quantidadeFaltas, quantidadeCompensacoes: $quantidadeCompensacoes, frequencia: $frequencia, corDaFrequencia: $corDaFrequencia, componentesCurricularesDoAluno: $componentesCurricularesDoAluno)';
  }

  @override
  bool operator ==(covariant Frequency other) {
    if (identical(this, other)) return true;
  
    return 
      other.anoLetivo == anoLetivo &&
      other.codigoUe == codigoUe &&
      other.codigoTurma == codigoTurma &&
      other.alunoCodigo == alunoCodigo &&
      other.quantidadeAulas == quantidadeAulas &&
      other.quantidadeFaltas == quantidadeFaltas &&
      other.quantidadeCompensacoes == quantidadeCompensacoes &&
      other.frequencia == frequencia &&
      other.corDaFrequencia == corDaFrequencia &&
      listEquals(other.componentesCurricularesDoAluno, componentesCurricularesDoAluno);
  }

  @override
  int get hashCode {
    return anoLetivo.hashCode ^
      codigoUe.hashCode ^
      codigoTurma.hashCode ^
      alunoCodigo.hashCode ^
      quantidadeAulas.hashCode ^
      quantidadeFaltas.hashCode ^
      quantidadeCompensacoes.hashCode ^
      frequencia.hashCode ^
      corDaFrequencia.hashCode ^
      componentesCurricularesDoAluno.hashCode;
  }
}
