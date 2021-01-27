class Ausencias {
  String data;
  int quantidadeDeFaltas;

  Ausencias({this.data, this.quantidadeDeFaltas});

  Ausencias.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    quantidadeDeFaltas = json['quantidadeDeFaltas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['quantidadeDeFaltas'] = this.quantidadeDeFaltas;
    return data;
  }
}
