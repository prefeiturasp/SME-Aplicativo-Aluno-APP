import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../interfaces/terms_repository_interface.dart';
import '../models/terms/term.dart';
import '../services/api.service.dart';
import '../utils/app_config_reader.dart';

class TermsRepository extends ITermsRepository {
  final api = GetIt.I.get<ApiService>();
  @override
  Future<Term> fetchTerms(String cpf) async {
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/TermosDeUso?cpf=$cpf');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final termo = Term.fromJson(decodeJson);
        return termo;
      } else if (response.statusCode == 204) {
        return Term(politicaDePrivacidade: '', termosDeUso: '', versao: 0);
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
  Future<Term> fetchTermsCurrentUser() async {
    try {
      final response = await api.dio.get('/TermosDeUso/logado');
      if (response.statusCode == 200) {
        final termo = Term.fromMap(response.data);
        return termo;
      } else {
        log('Erro ao obter dados fetchTermsCurrentUser');
        return Term.clear();
      }
    } catch (e) {
      log('Erro ao obter dados fetchTermsCurrentUser $e');
      return Term.clear();
    }
  }

  @override
  Future<bool> registerTerms(int termoDeUsoId, String cpf, String device, String ip, double versao) async {
    final Map data = {
      'termoDeUsoId': termoDeUsoId,
      'cpfUsuario': cpf,
      'device': device,
      'ip': ip,
      'versao': versao,
    };

    final body = json.encode(data);

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/TermosDeUso/registrar-aceite');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
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
