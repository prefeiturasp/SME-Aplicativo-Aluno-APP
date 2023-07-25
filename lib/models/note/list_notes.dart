// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'note.dart';

class ListNotes {
  int? anoLetivo;
  String? codigoUe;
  String? codigoTurma;
  String? alunoCodigo;
  int? bimestre;
  String? recomendacoesFamilia;
  String? recomendacoesAluno;
  List<Note> notasPorComponenteCurricular = [];

  ListNotes({
    this.anoLetivo,
    this.codigoUe,
    this.codigoTurma,
    this.alunoCodigo,
    this.bimestre,
    this.recomendacoesFamilia,
    this.recomendacoesAluno,
    required this.notasPorComponenteCurricular,
  });

  ListNotes.fromJson(Map<String, dynamic> json) {
    anoLetivo = json['anoLetivo'];
    codigoUe = json['codigoUe'];
    codigoTurma = json['codigoTurma'];
    alunoCodigo = json['alunoCodigo'];
    bimestre = json['bimestre'];
    recomendacoesFamilia = json['recomendacoesFamilia'];
    recomendacoesAluno = json['recomendacoesAluno'];
    if (json['notasPorComponenteCurricular'] != null) {
      notasPorComponenteCurricular = [];
      json['notasPorComponenteCurricular'].forEach((v) {
        notasPorComponenteCurricular.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['anoLetivo'] = anoLetivo;
    data['codigoUe'] = codigoUe;
    data['codigoTurma'] = codigoTurma;
    data['alunoCodigo'] = alunoCodigo;
    data['bimestre'] = bimestre;
    data['recomendacoesFamilia'] = recomendacoesFamilia;
    data['recomendacoesAluno'] = recomendacoesAluno;
    data['notasPorComponenteCurricular'] = notasPorComponenteCurricular.map((v) => v.toJson()).toList();
    return data;
  }
}

class NotasPorComponenteCurricular {
  final String componenteCurricular;
  final String nota;
  final String notaDescricao;
  final String corNotaAluno;

  NotasPorComponenteCurricular({
    required this.componenteCurricular,
    required this.nota,
    required this.notaDescricao,
    required this.corNotaAluno,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'componenteCurricular': componenteCurricular,
      'nota': nota,
      'notaDescricao': notaDescricao,
      'corNotaAluno': corNotaAluno,
    };
  }

  factory NotasPorComponenteCurricular.fromMap(Map<String, dynamic> map) {
    return NotasPorComponenteCurricular(
      componenteCurricular: map['componenteCurricular'] as String,
      nota: map['nota'] as String,
      notaDescricao: map['notaDescricao'] as String,
      corNotaAluno: map['corNotaAluno'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotasPorComponenteCurricular.fromJson(String source) =>
      NotasPorComponenteCurricular.fromMap(json.decode(source) as Map<String, dynamic>);
}
