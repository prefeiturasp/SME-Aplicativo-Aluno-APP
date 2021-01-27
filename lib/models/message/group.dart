class Group {
  int id;
  String codigo;

  Group({this.id, this.codigo});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigo'] = this.codigo;
    return data;
  }
}
