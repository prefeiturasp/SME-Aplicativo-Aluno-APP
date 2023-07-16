import 'dart:convert';
import 'dart:developer';
import 'package:sme_app_aluno/interfaces/terms_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/models/terms/term.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class TermsRepository extends ITermsRepository {
  @override
  Future<dynamic> fetchTerms(String cpf) async {
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/TermosDeUso?cpf=$cpf");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      } else if (response.statusCode == 204) {
        return Term();
      } else {
        log('Erro ao obter dados');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      log('$e');
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> fetchTermsCurrentUser() async {
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/TermosDeUso/logado");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      } else if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 408) {
        return UsuarioDataModel(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        log('Erro ao obter dados');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      log('$e');
      throw Exception(e);
    }
  }

  @override
  Future<bool> registerTerms(int termoDeUsoId, String cpf, String device, String ip, double versao) async {
    Map data = {
      "termoDeUsoId": termoDeUsoId,
      "cpfUsuario": cpf,
      "device": device,
      "ip": ip,
      "versao": versao,
    };

    var body = json.encode(data);

    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/TermosDeUso/registrar-aceite");
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      if (response.statusCode == 200) {
        return response.body == true.toString() ? true : false;
      } else {
        log('Erro ao obter dados');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      log('$e');

      throw Exception(e);
    }
  }
}
