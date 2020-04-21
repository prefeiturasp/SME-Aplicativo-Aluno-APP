class User {
  int id;
  String nome;
  String cpf;
  Null email;
  String token;

  User({this.id, this.nome, this.cpf, this.email, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
