// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
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
  DateTime? ultimaAtualizacao;
  String? senha;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.nomeMae,
    required this.cpf,
    required this.email,
    required this.token,
    required this.primeiroAcesso,
    required this.atualizarDadosCadastrais,
    required this.celular,
    required this.dataNascimento,
    this.ultimaAtualizacao,
    this.senha,
  });

  UsuarioModel copyWith({
    int? id,
    String? nome,
    String? nomeMae,
    String? cpf,
    String? email,
    String? token,
    bool? primeiroAcesso,
    bool? atualizarDadosCadastrais,
    String? celular,
    DateTime? dataNascimento,
    DateTime? ultimaAtualizacao,
    String? senha,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      nomeMae: nomeMae ?? this.nomeMae,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      token: token ?? this.token,
      primeiroAcesso: primeiroAcesso ?? this.primeiroAcesso,
      atualizarDadosCadastrais: atualizarDadosCadastrais ?? this.atualizarDadosCadastrais,
      celular: celular ?? this.celular,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      ultimaAtualizacao: ultimaAtualizacao ?? this.ultimaAtualizacao,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'nomeMae': nomeMae,
      'cpf': cpf,
      'email': email,
      'token': token,
      'primeiroAcesso': primeiroAcesso,
      'atualizarDadosCadastrais': atualizarDadosCadastrais,
      'celular': celular,
      'dataNascimento': dataNascimento.toIso8601String(),
      'ultimaAtualizacao': ultimaAtualizacao?.toIso8601String(),
      'senha': senha,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    final usr = UsuarioModel(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      nomeMae: map['nomeMae'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      primeiroAcesso: map['primeiroAcesso'] ?? false,
      atualizarDadosCadastrais: map['atualizarDadosCadastrais'] ?? false,
      celular: map['celular'] ?? '',
      dataNascimento: DateTime.parse(map['dataNascimento']),
      ultimaAtualizacao: DateTime.parse(map['ultimaAtualizacao']),
      senha: map['senha'] ?? '',
    );
    return usr;
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, nomeMae: $nomeMae, cpf: $cpf, email: $email, token: $token, primeiroAcesso: $primeiroAcesso, atualizarDadosCadastrais: $atualizarDadosCadastrais, celular: $celular, dataNascimento: $dataNascimento, ultimaAtualizacao: $ultimaAtualizacao, senha: $senha)';
  }

  @override
  bool operator ==(covariant UsuarioModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.nomeMae == nomeMae &&
        other.cpf == cpf &&
        other.email == email &&
        other.token == token &&
        other.primeiroAcesso == primeiroAcesso &&
        other.atualizarDadosCadastrais == atualizarDadosCadastrais &&
        other.celular == celular &&
        other.dataNascimento == dataNascimento &&
        other.ultimaAtualizacao == ultimaAtualizacao &&
        other.senha == senha;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        nomeMae.hashCode ^
        cpf.hashCode ^
        email.hashCode ^
        token.hashCode ^
        primeiroAcesso.hashCode ^
        atualizarDadosCadastrais.hashCode ^
        celular.hashCode ^
        dataNascimento.hashCode ^
        ultimaAtualizacao.hashCode ^
        senha.hashCode;
  }

  void clear() {
    id = 0;
    nome = '';
    nomeMae = '';
    cpf = '';
    email = '';
    token = '';
    primeiroAcesso = false;
    atualizarDadosCadastrais = false;
    celular = '';
    dataNascimento = DateTime.now();
    ultimaAtualizacao = null;
    senha = '';
  }

  factory UsuarioModel.clear() {
    return UsuarioModel(
      id: 0,
      nome: '',
      nomeMae: '',
      cpf: '',
      email: '',
      token: '',
      primeiroAcesso: false,
      atualizarDadosCadastrais: false,
      celular: '',
      dataNascimento: DateTime.now(),
      ultimaAtualizacao: null,
      senha: '',
    );
  }
}
