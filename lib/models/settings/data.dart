// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../dtos/validacao_erro_dto.dart';

class Data {
  bool ok;
  List<String> erros;
  ValidacaoErros validacaoErros;
  String token;
  Data({
    required this.ok,
    required this.erros,
    required this.validacaoErros,
    required this.token,
  });

  

  Data copyWith({
    bool? ok,
    List<String>? erros,
    ValidacaoErros? validacaoErros,
    String? token,
  }) {
    return Data(
      ok: ok ?? this.ok,
      erros: erros ?? this.erros,
      validacaoErros: validacaoErros ?? this.validacaoErros,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'erros': erros,
      'validacaoErros': validacaoErros.toMap(),
      'token': token,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      ok: map['ok'],
      erros: List<String>.from((map['erros'] as List<String>)),
      token: map['token'] as String,
      validacaoErros: ValidacaoErros.fromMap(map['validacaoErros']),
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(ok: $ok, erros: $erros, validacaoErros: $validacaoErros, token: $token)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;
  
    return 
      other.ok == ok &&
      listEquals(other.erros, erros) &&
      other.validacaoErros == validacaoErros &&
      other.token == token;
  }

  @override
  int get hashCode {
    return ok.hashCode ^
      erros.hashCode ^
      validacaoErros.hashCode ^
      token.hashCode;
  }
}
