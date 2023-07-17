// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../user/user.dart';

class DataUser {
  bool ok;
  List<String> erros;
  User data;
  DataUser({
    required this.ok,
    required this.erros,
    required this.data,
  });

  DataUser copyWith({
    bool? ok,
    List<String>? erros,
    User? data,
  }) {
    return DataUser(
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

  factory DataUser.fromMap(Map<String, dynamic> map) {
    return DataUser(ok: map['ok'], erros: List<String>.from((map['erros'])), data: User.fromMap(map['data']));
  }

  String toJson() => json.encode(toMap());

  factory DataUser.fromJson(String source) => DataUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataUser(ok: $ok, erros: $erros, data: $data)';

  @override
  bool operator ==(covariant DataUser other) {
    if (identical(this, other)) return true;

    return other.ok == ok && listEquals(other.erros, erros) && other.data == data;
  }

  @override
  int get hashCode => ok.hashCode ^ erros.hashCode ^ data.hashCode;
}
