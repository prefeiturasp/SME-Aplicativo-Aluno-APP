import 'dart:convert';

import 'package:flutter/foundation.dart';

class ResponseDTO {
  bool ok = false;
  List<String>? erros;
  Object? data;
  ResponseDTO({
    required this.ok,
    this.erros,
    this.data,
  });

  ResponseDTO copyWith({
    bool? ok,
    List<String>? erros,
    Object? data,
  }) {
    return ResponseDTO(
      ok: ok ?? this.ok,
      erros: erros ?? this.erros,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'erros': erros,
    };
  }

  factory ResponseDTO.fromMap(Map<String, dynamic> map) {
    return ResponseDTO(
      ok: map['ok'] as bool,
      erros: map['erros'] != null ? List<String>.from((map['erros'] as List<String>)) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseDTO.fromJson(String source) => ResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseDTO(ok: $ok, erros: $erros, data: $data)';

  @override
  bool operator ==(covariant ResponseDTO other) {
    if (identical(this, other)) return true;

    return other.ok == ok && listEquals(other.erros, erros) && other.data == data;
  }

  @override
  int get hashCode => ok.hashCode ^ erros.hashCode ^ data.hashCode;
}
