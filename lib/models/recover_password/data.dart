import 'package:sme_app_aluno/models/recover_password/validacao_erros.dart';

class Data {
  bool ok;
  List<String> erros;
  ValidacaoErros validacaoErros;
  String email;

  Data({this.ok, this.erros, this.validacaoErros, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'].cast<String>();
    validacaoErros = json['validacaoErros'] != null
        ? new ValidacaoErros.fromJson(json['validacaoErros'])
        : null;
    email = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['erros'] = this.erros;
    if (this.validacaoErros != null) {
      data['validacaoErros'] = this.validacaoErros.toJson();
    }
    data['data'] = this.email;
    return data;
  }
}
