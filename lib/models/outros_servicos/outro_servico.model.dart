import 'dart:convert';

class OutroServicoModel {
  String categoria;
  String titulo;
  String descricao;
  String urlSite;
  String icone;
  bool destaque;
  OutroServicoModel({
    required this.categoria,
    required this.titulo,
    required this.descricao,
    required this.urlSite,
    required this.icone,
    required this.destaque,
  });

  OutroServicoModel copyWith({
    String? categoria,
    String? titulo,
    String? descricao,
    String? urlSite,
    String? icone,
    bool? destaque,
  }) {
    return OutroServicoModel(
      categoria: categoria ?? this.categoria,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      urlSite: urlSite ?? this.urlSite,
      icone: icone ?? this.icone,
      destaque: destaque ?? this.destaque,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoria': categoria,
      'titulo': titulo,
      'descricao': descricao,
      'urlSite': urlSite,
      'icone': icone,
      'destaque': destaque,
    };
  }

  factory OutroServicoModel.fromMap(Map<String, dynamic> map) {
    final outros = OutroServicoModel(
      categoria: map['categoria'] as String,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      urlSite: map['urlSite'] as String,
      icone: map['icone'] as String,
      destaque: map['destaque'] as bool,
    );
    return outros;
  }

  String toJson() => json.encode(toMap());

  factory OutroServicoModel.fromJson(String source) =>
      OutroServicoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OutroServicoModel(categoria: $categoria, titulo: $titulo, descricao: $descricao, urlSite: $urlSite, icone: $icone, destaque: $destaque)';
  }

  @override
  bool operator ==(covariant OutroServicoModel other) {
    if (identical(this, other)) return true;

    return other.categoria == categoria &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.urlSite == urlSite &&
        other.icone == icone &&
        other.destaque == destaque;
  }

  @override
  int get hashCode {
    return categoria.hashCode ^
        titulo.hashCode ^
        descricao.hashCode ^
        urlSite.hashCode ^
        icone.hashCode ^
        destaque.hashCode;
  }
}
