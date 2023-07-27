// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'outro_servico.model.dart';

class OutrosServicosCategoria {
  String categoria;
  List<OutroServicoModel> outrosServicos;
  OutrosServicosCategoria({
    required this.categoria,
    required this.outrosServicos,
  });

  OutrosServicosCategoria copyWith({
    String? categoria,
    List<OutroServicoModel>? outrosServicos,
  }) {
    return OutrosServicosCategoria(
      categoria: categoria ?? this.categoria,
      outrosServicos: outrosServicos ?? this.outrosServicos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoria': categoria,
      'outrosServicos': outrosServicos.map((x) => x.toMap()).toList(),
    };
  }

  factory OutrosServicosCategoria.fromMap(Map<String, dynamic> map) {
    return OutrosServicosCategoria(
      categoria: map['categoria'] as String,
      outrosServicos: List<OutroServicoModel>.from(
        (map['outrosServicos'] as List<int>).map<OutroServicoModel>(
          (x) => OutroServicoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OutrosServicosCategoria.fromJson(String source) =>
      OutrosServicosCategoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OutrosServicosCategoria(categoria: $categoria, outrosServicos: $outrosServicos)';

  @override
  bool operator ==(covariant OutrosServicosCategoria other) {
    if (identical(this, other)) return true;

    return other.categoria == categoria && listEquals(other.outrosServicos, outrosServicos);
  }

  @override
  int get hashCode => categoria.hashCode ^ outrosServicos.hashCode;
}
