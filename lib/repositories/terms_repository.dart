import 'dart:convert';
import 'package:sme_app_aluno/interfaces/terms_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/terms/term.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/global_config.dart';

class TermsRepository extends ITermsRepository {
  @override
  Future<dynamic> fetchTerms(String cpf) async {
    try {
      var response = await http.get("${Api.HOST}/TermosDeUso?cpf=$cpf");
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      } else if (response.statusCode == 204) {
        return Term();
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  @override
  Future<dynamic> fetchTermsCurrentUser() async {
    try {
      var response = await http.get("${Api.HOST}/TermosDeUso/logado");
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      } else if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 408) {
        return Data(ok: false, erros: [GlobalConfig.ERROR_MESSAGE_TIME_OUT]);
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  @override
  Future<bool> registerTerms(int termoDeUsoId, String cpf, String device,
      String ip, double versao) async {
    Map data = {
      "termoDeUsoId": termoDeUsoId,
      "cpfUsuario": cpf,
      "device": device,
      "ip": ip,
      "versao": versao,
    };

    var body = json.encode(data);

    try {
      var response = await http.post("${Api.HOST}/TermosDeUso/registrar-aceite",
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      if (response.statusCode == 200) {
        return response.body == true.toString() ? true : false;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
