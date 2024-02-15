import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'app_config_reader.dart';

class Request {
  //START GET
  static Future<http.Response> getURL(String endPoint, Map<String, String> headers, param2) async {
    try {
      final uri = Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request GET: $uri');

      final response = await http.get(
        uri,
        headers: headers,
      );

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('Erro: $e');
      throw Exception(e);
    }
  }

  //START POST
  static Future<http.Response> postURL(String endPoint, Map<String, String> headers, Map<String, String> body) async {
    try {
      final uri = Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request POST: $uri');

      final response = await http.post(uri, headers: headers, body: body);

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('Erro: $e');
      throw Exception(e);
    }
  }

  //START PUT
  static Future<http.Response> putURL(String endPoint, Map<String, String> headers, Map<String, String> body) async {
    try {
      final uri = Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request POST: $uri');

      final response = await http.put(uri, headers: headers, body: body);

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      GetIt.I.get<SentryClient>().captureException('Erro: $e');
      throw Exception(e);
    }
  }
}
