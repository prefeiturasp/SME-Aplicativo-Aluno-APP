import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class Request {
  //START GET
  static getURL(String endPoint, Map<String, String> headers, param2) async {
    try {
      var uri =Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request GET: ' + uri.toString());

      var response = await http.get(
        uri,
        headers: headers,
      );

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      log('Erro: $e');
      throw Exception(e);
    }
  }

  //START POST
  static postURL(String endPoint, Map<String, String> headers, Map<String, String> body) async {
    try {
      var uri =Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request POST: ' + uri.toString());

      var response = await http.post(uri, headers: headers, body: body);

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      log('Erro: $e');
      throw Exception(e);
    }
  }

  //START PUT
  static putURL(String endPoint, Map<String, String> headers, Map<String, String> body) async {
    try {
      var uri =Uri.parse(AppConfigReader.getApiHost() + endPoint);

      log('HTTP Request POST: ' + uri.toString());

      var response = await http.put(uri, headers: headers, body: body);

      log('HTTP Response StatusCode: ${response.statusCode}');
      log('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      log('Erro: $e');
      throw Exception(e);
    }
  }
}
