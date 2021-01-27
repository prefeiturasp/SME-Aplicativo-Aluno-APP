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

  DadosUE(
      {this.nomeCompletoUe,
      this.tipoLogradouro,
      this.logradouro,
      this.numero,
      this.bairro,
      this.cep,
      this.municipio,
      this.uf,
      this.email,
      this.telefone});

  DadosUE.fromJson(Map<String, dynamic> json) {
    nomeCompletoUe = json['nomeCompletoUe'];
    tipoLogradouro = json['tipoLogradouro'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    bairro = json['bairro'];
    cep = json['cep'];
    municipio = json['municipio'];
    uf = json['uf'];
    email = json['email'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeCompletoUe'] = this.nomeCompletoUe;
    data['tipoLogradouro'] = this.tipoLogradouro;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['municipio'] = this.municipio;
    data['uf'] = this.uf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    return data;
  }
}
