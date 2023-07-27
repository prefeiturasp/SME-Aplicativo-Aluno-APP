// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../grupo_estudante.model.dart';

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
    final estudandeMap = DataStudent(
      ok: map['ok'],
      erros: List<String>.from((map['erros'])),
      data: List<GrupoEstudanteModel>.from(
        (map['data'] as List<dynamic>).map<GrupoEstudanteModel>(
          (x) => GrupoEstudanteModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
    return estudandeMap;
  }
  String toJson() => json.encode(toMap());

  factory DataStudent.fromJson(String source) {
    final jsonString = json.decode(source);
    final estudandte = DataStudent.fromMap(jsonString as Map<String, dynamic>);
    return estudandte;
  }

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
