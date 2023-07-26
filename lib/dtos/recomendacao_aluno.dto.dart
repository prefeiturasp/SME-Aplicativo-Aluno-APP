// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecomendacaoAlunoDto {
  String? alunoCodigo;
  String? turmaCodigo;
  String? anotacoesPedagogicas;
  String? recomendacoesAluno;
  String? recomendacoesFamilia;
  String? mensagemAlerta;
  bool? erro;

  RecomendacaoAlunoDto({
    this.alunoCodigo,
    this.turmaCodigo,
    this.anotacoesPedagogicas,
    this.recomendacoesAluno,
    this.recomendacoesFamilia,
    this.mensagemAlerta,
    this.erro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alunoCodigo': alunoCodigo,
      'turmaCodigo': turmaCodigo,
      'anotacoesPedagogicas': anotacoesPedagogicas,
      'recomendacoesAluno': recomendacoesAluno,
      'recomendacoesFamilia': recomendacoesFamilia,
      'mensagemAlerta': mensagemAlerta,
      'erro': erro,
    };
  }

  factory RecomendacaoAlunoDto.fromMap(Map<String, dynamic> map) {
    return RecomendacaoAlunoDto(
      alunoCodigo: map['alunoCodigo'] != null ? map['alunoCodigo'] as String : null,
      turmaCodigo: map['turmaCodigo'] != null ? map['turmaCodigo'] as String : null,
      anotacoesPedagogicas: map['anotacoesPedagogicas'] != null ? map['anotacoesPedagogicas'] as String : null,
      recomendacoesAluno: map['recomendacoesAluno'] != null ? map['recomendacoesAluno'] as String : null,
      recomendacoesFamilia: map['recomendacoesFamilia'] != null ? map['recomendacoesFamilia'] as String : null,
      mensagemAlerta: map['mensagemAlerta'] != null ? map['mensagemAlerta'] as String : null,
      erro: map['erro'] != null ? map['erro'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecomendacaoAlunoDto.fromJson(String source) =>
      RecomendacaoAlunoDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
