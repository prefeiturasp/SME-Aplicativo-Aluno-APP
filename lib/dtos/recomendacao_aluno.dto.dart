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

  RecomendacaoAlunoDto.fromJson(Map<String, dynamic> json) {
    this.alunoCodigo = json['alunoCodigo'];
    this.turmaCodigo = json['turmaCodigo'];
    this.anotacoesPedagogicas = json['anotacoesPedagogicas'];
    this.recomendacoesAluno = json['recomendacoesAluno'];
    this.recomendacoesFamilia = json['recomendacoesFamilia'];
    this.mensagemAlerta = json['mensagemAlerta'];
    this.erro = false;
  }
}
