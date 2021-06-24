class User {
  int id;
  String nome;
  String nomeMae;
  String cpf;
  String email;
  String token;
  bool primeiroAcesso;
  bool atualizarDadosCadastrais;
  String celular;
  DateTime dataNascimento;
  String senha;

  User(
      {this.id,
      this.nome,
      this.cpf,
      this.email,
      this.token,
      this.primeiroAcesso,
      this.atualizarDadosCadastrais,
      this.celular,
      this.dataNascimento});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    nomeMae = json['nomeMae'];
    token = json['token'];
    primeiroAcesso = json['primeiroAcesso'];
    atualizarDadosCadastrais = json['atualizarDadosCadastrais'];
    celular = json['celular'];
    dataNascimento = DateTime.parse(json['dataNascimento']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'nomeMae': nomeMae,
      'token': token,
      'primeiroAcesso': primeiroAcesso ? 1 : 0,
      'atualizarDadosCadastrais': atualizarDadosCadastrais ? 1 : 0,
      'celular': celular,
      'dataNascimento': dataNascimento
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['nomeMae'] = this.nomeMae;
    data['token'] = this.token;
    data['primeiroAcesso'] = this.primeiroAcesso;
    data['atualizarDadosCadastrais'] = this.atualizarDadosCadastrais;
    data['celular'] = this.celular;
    data['dataNascimento'] = this.dataNascimento.toString();
    return data;
  }
}
