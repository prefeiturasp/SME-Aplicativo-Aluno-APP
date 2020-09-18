import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sme_app_aluno/interfaces/terms_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/terms/term.dart';
import 'package:sme_app_aluno/utils/api.dart';

class TermsRepository extends ITermsRepository {

  @override
  Future<dynamic> fetchTerms(String cpf) async {

    try {
      var response = await http.get("${Api.HOST}/TermosDeUso?cpf=$cpf");
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      }else if(response.statusCode == 204){
        return true;
      }else {
        // var decodeError = jsonDecode(response.body);
        // var termoError = Termo.fromJson(decodeError);
        // return termoError;
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  @override
  Future<bool> registerTerms(int termoDeUsoId, String usuario, String device,
      String ip, double versao) async {
    Map data = {
      "termoDeUsoId": termoDeUsoId,
      "usuario": usuario,
      "device": device,
      "ip": ip,
      "versao": versao,
    };

    var body = json.encode(data);

    try {
      var response = await http.post("${Api.HOST}/TermosDeUso/registrar-aceite",
          body: body);
      if (response.statusCode == 200) {
        return response.body == true.toString() ? true : false;
      } else {
        // var decodeError = jsonDecode(response.body);
        // var termoError = Termo.fromJson(decodeError);
        // return termoError;
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
