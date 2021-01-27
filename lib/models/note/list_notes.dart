import 'package:sme_app_aluno/models/note/note.dart';

class ListNotes {
  int anoLetivo;
  String codigoUe;
  String codigoTurma;
  String alunoCodigo;
  int bimestre;
  String recomendacoesFamilia;
  String recomendacoesAluno;
  List<Note> notasPorComponenteCurricular;

  ListNotes(
      {this.anoLetivo,
      this.codigoUe,
      this.codigoTurma,
      this.alunoCodigo,
      this.bimestre,
      this.recomendacoesFamilia,
      this.recomendacoesAluno,
      this.notasPorComponenteCurricular});

  ListNotes.fromJson(Map<String, dynamic> json) {
    anoLetivo = json['anoLetivo'];
    codigoUe = json['codigoUe'];
    codigoTurma = json['codigoTurma'];
    alunoCodigo = json['alunoCodigo'];
    bimestre = json['bimestre'];
    recomendacoesFamilia = json['recomendacoesFamilia'];
    recomendacoesAluno = json['recomendacoesAluno'];
    if (json['notasPorComponenteCurricular'] != null) {
      notasPorComponenteCurricular = new List<Note>();
      json['notasPorComponenteCurricular'].forEach((v) {
        notasPorComponenteCurricular.add(new Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anoLetivo'] = this.anoLetivo;
    data['codigoUe'] = this.codigoUe;
    data['codigoTurma'] = this.codigoTurma;
    data['alunoCodigo'] = this.alunoCodigo;
    data['bimestre'] = this.bimestre;
    data['recomendacoesFamilia'] = this.recomendacoesFamilia;
    data['recomendacoesAluno'] = this.recomendacoesAluno;
    if (this.notasPorComponenteCurricular != null) {
      data['notasPorComponenteCurricular'] =
          this.notasPorComponenteCurricular.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotasPorComponenteCurricular {
  String componenteCurricular;
  String nota;
  Null notaDescricao;
  String corNotaAluno;

  NotasPorComponenteCurricular(
      {this.componenteCurricular,
      this.nota,
      this.notaDescricao,
      this.corNotaAluno});

  NotasPorComponenteCurricular.fromJson(Map<String, dynamic> json) {
    componenteCurricular = json['componenteCurricular'];
    nota = json['nota'];
    notaDescricao = json['notaDescricao'];
    corNotaAluno = json['corNotaAluno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['componenteCurricular'] = this.componenteCurricular;
    data['nota'] = this.nota;
    data['notaDescricao'] = this.notaDescricao;
    data['corNotaAluno'] = this.corNotaAluno;
    return data;
  }
}
