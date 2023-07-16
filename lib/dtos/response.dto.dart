class ResponseDTO {
  bool? ok;
  List<String>? erros;
  Object? data;

  ResponseDTO({this.ok, this.erros, this.data});

  ResponseDTO.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    erros = json['erros'].cast<String>();
  }
}
