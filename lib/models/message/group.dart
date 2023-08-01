// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Group {
  int id = 0;
  String codigo;
  Group({
    this.id = 0,
    required this.codigo,
  });

  Group copyWith({
    int? id,
    String? codigo,
  }) {
    return Group(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'codigo': codigo,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as int,
      codigo: map['codigo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Group(id: $id, codigo: $codigo)';

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode;
}
