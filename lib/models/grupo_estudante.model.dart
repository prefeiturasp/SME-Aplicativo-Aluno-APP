// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sme_app_aluno/models/estudante.model.dart';

class GrupoEstudanteModel {
  String grupo;
  int codigoGrupo;
  List<EstudanteModel> estudantes;
  GrupoEstudanteModel({
    required this.grupo,
    required this.codigoGrupo,
    required this.estudantes,
  });

  GrupoEstudanteModel copyWith({
    String? grupo,
    int? codigoGrupo,
    List<EstudanteModel>? estudantes,
  }) {
    return GrupoEstudanteModel(
      grupo: grupo ?? this.grupo,
      codigoGrupo: codigoGrupo ?? this.codigoGrupo,
      estudantes: estudantes ?? this.estudantes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'grupo': grupo,
      'codigoGrupo': codigoGrupo,
      'estudantes': estudantes.map((x) => x.toMap()).toList(),
    };
  }

  factory GrupoEstudanteModel.fromMap(Map<String, dynamic> map) {
    return GrupoEstudanteModel(
      grupo: map['grupo'] as String,
      codigoGrupo: map['codigoGrupo'] as int,
      estudantes: List<EstudanteModel>.from(
        (map['estudantes'] as List<int>).map<EstudanteModel>(
          (x) => EstudanteModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GrupoEstudanteModel.fromJson(String source) =>
      GrupoEstudanteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GrupoEstudanteModel(grupo: $grupo, codigoGrupo: $codigoGrupo, estudantes: $estudantes)';

  @override
  bool operator ==(covariant GrupoEstudanteModel other) {
    if (identical(this, other)) return true;

    return other.grupo == grupo && other.codigoGrupo == codigoGrupo && listEquals(other.estudantes, estudantes);
  }

  @override
  int get hashCode => grupo.hashCode ^ codigoGrupo.hashCode ^ estudantes.hashCode;
}
