// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../index.dart';

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
  CurricularComponent({
    required this.anoLetivo,
    required this.codigoUe,
    required this.nomeUe,
    required this.codigoTurma,
    required this.nomeTurma,
    required this.alunoCodigo,
    required this.codigoComponenteCurricular,
    required this.componenteCurricular,
    required this.frequencias,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'anoLetivo': anoLetivo,
      'codigoUe': codigoUe,
      'nomeUe': nomeUe,
      'codigoTurma': codigoTurma,
      'nomeTurma': nomeTurma,
      'alunoCodigo': alunoCodigo,
      'codigoComponenteCurricular': codigoComponenteCurricular,
      'componenteCurricular': componenteCurricular,
      'frequencias': frequencias.map((x) => x.toMap()).toList(),
    };
  }

  factory CurricularComponent.fromMap(Map<String, dynamic> map) {
    return CurricularComponent(
      anoLetivo: map['anoLetivo'] as String,
      codigoUe: map['codigoUe'] as String,
      nomeUe: map['nomeUe'] as String,
      codigoTurma: map['codigoTurma'] as String,
      nomeTurma: map['nomeTurma'] as String,
      alunoCodigo: map['alunoCodigo'] as String,
      codigoComponenteCurricular: map['codigoComponenteCurricular'] as int,
      componenteCurricular: map['componenteCurricular'] as String,
      frequencias: List<EstudanteFrequenciaModel>.from((map['frequencias'] as List<int>).map<EstudanteFrequenciaModel>((x) => EstudanteFrequenciaModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurricularComponent.fromJson(String source) => CurricularComponent.fromMap(json.decode(source) as Map<String, dynamic>);
}
