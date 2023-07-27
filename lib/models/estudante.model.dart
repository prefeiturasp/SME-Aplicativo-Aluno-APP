import 'dart:convert';

class EstudanteModel {
  final int codigoEol;
  final String nome;
  final String nomeSocial;
  final String escola;
  final int codigoTipoEscola;
  final String descricaoTipoEscola;
  final String siglaDre;
  final String turma;
  final String situacaoMatricula;
  final String dataNascimento;
  final String dataSituacaoMatricula;
  final String codigoDre;
  final String codigoEscola;
  final int codigoTurma;
  final String serieResumida;

  EstudanteModel({
    required this.codigoEol,
    required this.nome,
    required this.nomeSocial,
    required this.escola,
    required this.codigoTipoEscola,
    required this.descricaoTipoEscola,
    required this.siglaDre,
    required this.codigoDre,
    required this.turma,
    required this.situacaoMatricula,
    required this.dataNascimento,
    required this.dataSituacaoMatricula,
    required this.codigoEscola,
    required this.codigoTurma,
    required this.serieResumida,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigoEol': codigoEol,
      'nome': nome,
      'nomeSocial': nomeSocial,
      'escola': escola,
      'codigoTipoEscola': codigoTipoEscola,
      'descricaoTipoEscola': descricaoTipoEscola,
      'siglaDre': siglaDre,
      'turma': turma,
      'situacaoMatricula': situacaoMatricula,
      'dataNascimento': dataNascimento,
      'dataSituacaoMatricula': dataSituacaoMatricula,
      'codigoDre': codigoDre,
      'codigoEscola': codigoEscola,
      'codigoTurma': codigoTurma,
      'serieResumida': serieResumida,
    };
  }

  factory EstudanteModel.fromMap(Map<String, dynamic> map) {
    return EstudanteModel(
      codigoEol: map['codigoEol'] as int,
      nome: map['nome'] ?? '',
      nomeSocial: map['nomeSocial'] ?? '',
      escola: map['escola'] ?? '',
      codigoTipoEscola: map['codigoTipoEscola'] as int,
      descricaoTipoEscola: map['descricaoTipoEscola'] ?? '',
      siglaDre: map['siglaDre'] ?? '',
      turma: map['turma'] ?? '',
      situacaoMatricula: map['situacaoMatricula'] ?? '',
      dataNascimento: map['dataNascimento'] ?? '',
      dataSituacaoMatricula: map['dataSituacaoMatricula'] ?? '',
      codigoDre: map['codigoDre'] ?? '',
      codigoEscola: map['codigoEscola'] ?? '',
      codigoTurma: map['codigoTurma'] as int,
      serieResumida: map['serieResumida'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EstudanteModel.fromJson(String source) => EstudanteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
