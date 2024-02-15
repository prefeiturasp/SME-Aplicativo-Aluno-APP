import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

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
        final termo = Term.fromJson(response.body);
        return termo;
      } else if (response.statusCode == 204) {
        return Term(politicaDePrivacidade: '', termosDeUso: '', versao: 0);
      } else {
        return Term(politicaDePrivacidade: '', termosDeUso: '', versao: 0);
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('$e');
      return Term(politicaDePrivacidade: '', termosDeUso: '', versao: 0);
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
        return Term.clear();
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('Erro ao obter dados fetchTermsCurrentUser $e');
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
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('$e');

      throw Exception(e);
    }
  }
}
