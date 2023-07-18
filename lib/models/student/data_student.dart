// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sme_app_aluno/models/grupo_estudante.model.dart';

class DataStudent {
  bool ok;
  List<String> erros;
  List<GrupoEstudanteModel> data;
  DataStudent({
    required this.ok,
    required this.erros,
    required this.data,
  });

  DataStudent copyWith({
    bool? ok,
    List<String>? erros,
    List<GrupoEstudanteModel>? data,
  }) {
    return DataStudent(
      ok: ok ?? this.ok,
      erros: erros ?? this.erros,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'erros': erros,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory DataStudent.fromMap(Map<String, dynamic> map) {
    return DataStudent(
      ok: map['ok'] as bool,
      erros: List<String>.from((map['erros'] as List<String>)),
      data: List<GrupoEstudanteModel>.from(
        (map['data'] as List<int>).map<GrupoEstudanteModel>(
          (x) => GrupoEstudanteModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataStudent.fromJson(String source) => DataStudent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataStudent(ok: $ok, erros: $erros, data: $data)';

  @override
  bool operator ==(covariant DataStudent other) {
    if (identical(this, other)) return true;

    return other.ok == ok && listEquals(other.erros, erros) && listEquals(other.data, data);
  }

  @override
  int get hashCode => ok.hashCode ^ erros.hashCode ^ data.hashCode;
}
