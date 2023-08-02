import 'dart:convert';

class Term {
  int id;
  String termosDeUso;
  String politicaDePrivacidade;
  double versao;
  Term({
    this.id = 0,
    required this.termosDeUso,
    required this.politicaDePrivacidade,
    required this.versao,
  });

  Term copyWith({
    int? id,
    String? termosDeUso,
    String? politicaDePrivacidade,
    double? versao,
  }) {
    return Term(
      id: id ?? this.id,
      termosDeUso: termosDeUso ?? this.termosDeUso,
      politicaDePrivacidade: politicaDePrivacidade ?? this.politicaDePrivacidade,
      versao: versao ?? this.versao,
    );
  }

  factory Term.clear() {
    return Term(
      id: 0,
      termosDeUso: '',
      politicaDePrivacidade: '',
      versao: 0,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'termosDeUso': termosDeUso,
      'politicaDePrivacidade': politicaDePrivacidade,
      'versao': versao,
    };
  }

  factory Term.fromMap(Map<String, dynamic> map) {
    return Term(
      id: map['id'] as int,
      termosDeUso: map['termosDeUso'] as String,
      politicaDePrivacidade: map['politicaDePrivacidade'] as String,
      versao: map['versao'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Term.fromJson(String source) => Term.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Term(id: $id, termosDeUso: $termosDeUso, politicaDePrivacidade: $politicaDePrivacidade, versao: $versao)';
  }

  @override
  bool operator ==(covariant Term other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.termosDeUso == termosDeUso &&
        other.politicaDePrivacidade == politicaDePrivacidade &&
        other.versao == versao;
  }

  @override
  int get hashCode {
    return id.hashCode ^ termosDeUso.hashCode ^ politicaDePrivacidade.hashCode ^ versao.hashCode;
  }
}
