// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  int id;
  String mensagem;
  String titulo;
  String dataEnvio;
  String criadoEm;
  String alteradoEm;
  bool mensagemVisualizada;
  String categoriaNotificacao;
  int codigoEOL;
  Message({
    required this.id,
    required this.mensagem,
    required this.titulo,
    required this.dataEnvio,
    required this.criadoEm,
    required this.alteradoEm,
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
      id: map['id'] as int,
      mensagem: map['mensagem'] as String,
      titulo: map['titulo'] as String,
      dataEnvio: map['dataEnvio'] as String,
      criadoEm: map['criadoEm'] as String,
      alteradoEm: map['alteradoEm'] as String,
      mensagemVisualizada: map['mensagemVisualizada'] as bool,
      categoriaNotificacao: map['categoriaNotificacao'] as String,
      codigoEOL: map['codigoEOL'] as int,
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
  
    return 
      other.id == id &&
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
