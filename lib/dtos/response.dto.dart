class ResponseDTO {
  bool ok = false;
  List<String>? erros;
  Object? data;

  ResponseDTO({this.ok = false, this.erros, this.data});

  ResponseDTO.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'].cast<String>();
  }
}
