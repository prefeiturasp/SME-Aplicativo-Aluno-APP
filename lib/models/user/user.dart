class User {
  int id;
  String nome;
  String cpf;
  String email;
  String token;
  bool primeiroAcesso;
  bool informarCelularEmail;
  String celular;
  String senha;

  User({
    this.id,
    this.nome,
    this.cpf,
    this.email,
    this.token,
    this.primeiroAcesso,
    this.informarCelularEmail,
    this.celular,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    token = json['token'];
    primeiroAcesso = json['primeiroAcesso'];
    informarCelularEmail = json['informarCelularEmail'];
    celular = json['celular'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'token': token,
      'primeiroAcesso': primeiroAcesso ? 1 : 0,
      'informarCelularEmail': informarCelularEmail ? 1 : 0,
      'celular': celular,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['token'] = this.token;
    data['primeiroAcesso'] = this.primeiroAcesso;
    data['informarCelularEmail'] = this.informarCelularEmail;
    data['celular'] = this.celular;
    return data;
  }
}
