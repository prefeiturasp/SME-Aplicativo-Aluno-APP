// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../dtos/validacao_erro_dto.dart';

class Data {
  bool ok;
  List<String> erros;
  ValidacaoErros validacaoErros;
  String email;
  Data({
    required this.ok,
    required this.erros,
    required this.validacaoErros,
    required this.email,
  });

  Data copyWith({
    bool? ok,
    List<String>? erros,
    ValidacaoErros? validacaoErros,
    String? email,
  }) {
    return Data(
      ok: ok ?? this.ok,
      erros: erros ?? this.erros,
      validacaoErros: validacaoErros ?? this.validacaoErros,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'erros': erros,
      'validacaoErros': validacaoErros.toMap(),
      'email': email,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
        ok: map['ok'],
        email: map['email'],
        erros: List<String>.from(map['erros'] as List<String>),
        validacaoErros: ValidacaoErros.fromMap(map['validacaoErros']),);
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(ok: $ok, erros: $erros, validacaoErros: $validacaoErros, email: $email)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.ok == ok &&
        listEquals(other.erros, erros) &&
        other.validacaoErros == validacaoErros &&
        other.email == email;
  }

  @override
  int get hashCode {
    return ok.hashCode ^ erros.hashCode ^ validacaoErros.hashCode ^ email.hashCode;
  }
}
