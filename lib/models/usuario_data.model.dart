// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sme_app_aluno/models/index.dart';

class UsuarioDataModel {
  bool ok;
  List<String> erros;
  UsuarioModel data;
  UsuarioDataModel({
    required this.ok,
    required this.erros,
    required this.data,
  });

  UsuarioDataModel copyWith({
    bool? ok,
    List<String>? erros,
    UsuarioModel? data,
  }) {
    return UsuarioDataModel(
      ok: ok ?? this.ok,
      erros: erros ?? this.erros,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'erros': erros,
      'data': data.toMap(),
    };
  }

  factory UsuarioDataModel.fromMap(Map<String, dynamic> map) {
    return UsuarioDataModel(
      ok: map['ok'] as bool,
      erros: List<String>.from((map['erros'] as List<String>)),
      data: UsuarioModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioDataModel.fromJson(String source) =>
      UsuarioDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UsuarioDataModel(ok: $ok, erros: $erros, data: $data)';

  @override
  bool operator ==(covariant UsuarioDataModel other) {
    if (identical(this, other)) return true;

    return other.ok == ok && listEquals(other.erros, erros) && other.data == data;
  }

  @override
  int get hashCode => ok.hashCode ^ erros.hashCode ^ data.hashCode;
}
