// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ValidacaoErros {
  List<String> additionalProp1 = [];
  List<String> additionalProp2 = [];
  List<String> additionalProp3 = [];
  ValidacaoErros({
    required this.additionalProp1,
    required this.additionalProp2,
    required this.additionalProp3,
  });

  ValidacaoErros copyWith({
    List<String>? additionalProp1,
    List<String>? additionalProp2,
    List<String>? additionalProp3,
  }) {
    return ValidacaoErros(
      additionalProp1: additionalProp1 ?? this.additionalProp1,
      additionalProp2: additionalProp2 ?? this.additionalProp2,
      additionalProp3: additionalProp3 ?? this.additionalProp3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'additionalProp1': additionalProp1,
      'additionalProp2': additionalProp2,
      'additionalProp3': additionalProp3,
    };
  }

  factory ValidacaoErros.fromMap(Map<String, dynamic> map) {
    return ValidacaoErros(
        additionalProp1: List<String>.from(map['additionalProp1'] as List<String>),
        additionalProp2: List<String>.from(map['additionalProp2'] as List<String>),
        additionalProp3: List<String>.from(
          (map['additionalProp3'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ValidacaoErros.fromJson(String source) => ValidacaoErros.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ValidacaoErros(additionalProp1: $additionalProp1, additionalProp2: $additionalProp2, additionalProp3: $additionalProp3)';

  @override
  bool operator ==(covariant ValidacaoErros other) {
    if (identical(this, other)) return true;

    return listEquals(other.additionalProp1, additionalProp1) &&
        listEquals(other.additionalProp2, additionalProp2) &&
        listEquals(other.additionalProp3, additionalProp3);
  }

  @override
  int get hashCode => additionalProp1.hashCode ^ additionalProp2.hashCode ^ additionalProp3.hashCode;
}
