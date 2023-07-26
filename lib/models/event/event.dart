import 'dart:convert';

class Event {
  final String nome;
  final String descricao;
  final String diaSemana;
  final String dataInicio;
  final String dataFim;
  final int tipoEvento;
  final int anoLetivo;
  final String componenteCurricular;
  Event({
    required this.nome,
    required this.descricao,
    required this.diaSemana,
    required this.dataInicio,
    required this.dataFim,
    required this.tipoEvento,
    required this.anoLetivo,
    required this.componenteCurricular,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'descricao': descricao,
      'diaSemana': diaSemana,
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'tipoEvento': tipoEvento,
      'anoLetivo': anoLetivo,
      'componenteCurricular': componenteCurricular,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      diaSemana: map['diaSemana'] ?? '',
      dataInicio: map['dataInicio'] ?? '',
      dataFim: map['dataFim'] ?? '',
      tipoEvento: map['tipoEvento'] ?? 0,
      anoLetivo: map['anoLetivo'] ?? 0,
      componenteCurricular: map['componenteCurricular'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
