// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DadosUE {
  String nomeCompletoUe;
  String tipoLogradouro;
  String logradouro;
  String numero;
  String bairro;
  int cep;
  String municipio;
  String uf;
  String email;
  String telefone;
  DadosUE({
    required this.nomeCompletoUe,
    required this.tipoLogradouro,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.cep,
    required this.municipio,
    required this.uf,
    required this.email,
    required this.telefone,
  });


  DadosUE copyWith({
    String? nomeCompletoUe,
    String? tipoLogradouro,
    String? logradouro,
    String? numero,
    String? bairro,
    int? cep,
    String? municipio,
    String? uf,
    String? email,
    String? telefone,
  }) {
    return DadosUE(
      nomeCompletoUe: nomeCompletoUe ?? this.nomeCompletoUe,
      tipoLogradouro: tipoLogradouro ?? this.tipoLogradouro,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      cep: cep ?? this.cep,
      municipio: municipio ?? this.municipio,
      uf: uf ?? this.uf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeCompletoUe': nomeCompletoUe,
      'tipoLogradouro': tipoLogradouro,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'cep': cep,
      'municipio': municipio,
      'uf': uf,
      'email': email,
      'telefone': telefone,
    };
  }

  factory DadosUE.fromMap(Map<String, dynamic> map) {
    return DadosUE(
      nomeCompletoUe: map['nomeCompletoUe'] as String? ?? '',
      tipoLogradouro: map['tipoLogradouro'] as String? ?? '',
      logradouro: map['logradouro'] as String? ?? '',
      numero: map['numero'] as String? ?? '',
      bairro: map['bairro'] as String? ?? '',
      cep: map['cep'] as int? ?? 0,
      municipio: map['municipio'] as String? ?? '',
      uf: map['uf'] as String? ?? '',
      email: map['email'] as String? ?? '',
      telefone: map['telefone'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosUE.fromJson(String source) => DadosUE.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DadosUE(nomeCompletoUe: $nomeCompletoUe, tipoLogradouro: $tipoLogradouro, logradouro: $logradouro, numero: $numero, bairro: $bairro, cep: $cep, municipio: $municipio, uf: $uf, email: $email, telefone: $telefone)';
  }

  @override
  bool operator ==(covariant DadosUE other) {
    if (identical(this, other)) return true;
  
    return 
      other.nomeCompletoUe == nomeCompletoUe &&
      other.tipoLogradouro == tipoLogradouro &&
      other.logradouro == logradouro &&
      other.numero == numero &&
      other.bairro == bairro &&
      other.cep == cep &&
      other.municipio == municipio &&
      other.uf == uf &&
      other.email == email &&
      other.telefone == telefone;
  }

  @override
  int get hashCode {
    return nomeCompletoUe.hashCode ^
      tipoLogradouro.hashCode ^
      logradouro.hashCode ^
      numero.hashCode ^
      bairro.hashCode ^
      cep.hashCode ^
      municipio.hashCode ^
      uf.hashCode ^
      email.hashCode ^
      telefone.hashCode;
  }
}
