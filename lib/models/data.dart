import 'package:sme_app_aluno/models/user.dart';

class Data {
  bool ok;
  List<String> erros;
  User user;

  Data({this.ok, this.erros, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'].cast<String>();
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['erros'] = this.erros;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
