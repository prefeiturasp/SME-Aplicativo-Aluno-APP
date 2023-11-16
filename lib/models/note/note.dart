class Note {
  String? componenteCurricular;
  String? nota;
  String? notaDescricao;
  String? corNotaAluno;

  Note({this.componenteCurricular, this.nota, this.notaDescricao, this.corNotaAluno});

  Note.fromJson(Map<String, dynamic> json) {
    componenteCurricular = json['componenteCurricular'];
    nota = json['nota'];
    notaDescricao = json['notaDescricao'];
    corNotaAluno = json['corNotaAluno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['componenteCurricular'] = componenteCurricular;
    data['nota'] = nota;
    data['notaDescricao'] = notaDescricao;
    data['corNotaAluno'] = corNotaAluno;
    return data;
  }
}
