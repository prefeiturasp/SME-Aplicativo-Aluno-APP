import 'dart:convert';

class Message {
  int id;
  String mensagem;
  String titulo;
  String dataEnvio;
  String criadoEm;
  String? alteradoEm;
  bool mensagemVisualizada;
  String categoriaNotificacao;
  int codigoEOL;
  Message({
    this.alteradoEm,
    required this.id,
    required this.mensagem,
    required this.titulo,
    required this.dataEnvio,
    required this.criadoEm,
    required this.mensagemVisualizada,
    required this.categoriaNotificacao,
    required this.codigoEOL,
  });

  Message copyWith({
    int? id,
    String? mensagem,
    String? titulo,
    String? dataEnvio,
    String? criadoEm,
    String? alteradoEm,
    bool? mensagemVisualizada,
    String? categoriaNotificacao,
    int? codigoEOL,
  }) {
    return Message(
      id: id ?? this.id,
      mensagem: mensagem ?? this.mensagem,
      titulo: titulo ?? this.titulo,
      dataEnvio: dataEnvio ?? this.dataEnvio,
      criadoEm: criadoEm ?? this.criadoEm,
      alteradoEm: alteradoEm ?? this.alteradoEm,
      mensagemVisualizada: mensagemVisualizada ?? this.mensagemVisualizada,
      categoriaNotificacao: categoriaNotificacao ?? this.categoriaNotificacao,
      codigoEOL: codigoEOL ?? this.codigoEOL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mensagem': mensagem,
      'titulo': titulo,
      'dataEnvio': dataEnvio,
      'criadoEm': criadoEm,
      'alteradoEm': alteradoEm,
      'mensagemVisualizada': mensagemVisualizada,
      'categoriaNotificacao': categoriaNotificacao,
      'codigoEOL': codigoEOL,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? 0,
      mensagem: map['mensagem'] ?? '',
      titulo: map['titulo'] ?? '',
      dataEnvio: map['dataEnvio'] ?? '',
      criadoEm: map['criadoEm'] ?? '',
      alteradoEm: map['alteradoEm'],
      mensagemVisualizada: map['mensagemVisualizada'] ?? false,
      categoriaNotificacao: map['categoriaNotificacao'] ?? '',
      codigoEOL: map['codigoEOL'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, mensagem: $mensagem, titulo: $titulo, dataEnvio: $dataEnvio, criadoEm: $criadoEm, alteradoEm: $alteradoEm, mensagemVisualizada: $mensagemVisualizada, categoriaNotificacao: $categoriaNotificacao, codigoEOL: $codigoEOL)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.mensagem == mensagem &&
        other.titulo == titulo &&
        other.dataEnvio == dataEnvio &&
        other.criadoEm == criadoEm &&
        other.alteradoEm == alteradoEm &&
        other.mensagemVisualizada == mensagemVisualizada &&
        other.categoriaNotificacao == categoriaNotificacao &&
        other.codigoEOL == codigoEOL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        mensagem.hashCode ^
        titulo.hashCode ^
        dataEnvio.hashCode ^
        criadoEm.hashCode ^
        alteradoEm.hashCode ^
        mensagemVisualizada.hashCode ^
        categoriaNotificacao.hashCode ^
        codigoEOL.hashCode;
  }
}
