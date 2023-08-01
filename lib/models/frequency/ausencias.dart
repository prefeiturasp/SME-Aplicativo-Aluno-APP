// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ausencias {
  final String data;
  final int quantidadeDeFaltas;

  Ausencias({required this.data, required this.quantidadeDeFaltas});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'quantidadeDeFaltas': quantidadeDeFaltas,
    };
  }

  factory Ausencias.fromMap(Map<String, dynamic> map) {
    return Ausencias(
      data: map['data'] as String,
      quantidadeDeFaltas: map['quantidadeDeFaltas'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ausencias.fromJson(String source) => Ausencias.fromMap(json.decode(source) as Map<String, dynamic>);
}
