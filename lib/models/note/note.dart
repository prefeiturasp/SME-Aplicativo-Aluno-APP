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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['componenteCurricular'] = this.componenteCurricular;
    data['nota'] = this.nota;
    data['notaDescricao'] = this.notaDescricao;
    data['corNotaAluno'] = this.corNotaAluno;
    return data;
  }
}
