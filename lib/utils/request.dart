import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class Request {
  //START GET
  static getURL(String endPoint, Map<String, String> headers, param2) async {
    try {
      var uri = AppConfigReader.getApiHost() + endPoint;

      print('HTTP Request GET: ' + uri);

      var response = await http.get(
        uri,
        headers: headers,
      );

      print('HTTP Response StatusCode: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      print('Erro: $e');
    }
  }

  //START POST
  static postURL(String endPoint, Map<String, String> headers,
      Map<String, String> body) async {
    try {
      var uri = AppConfigReader.getApiHost() + endPoint;

      print('HTTP Request POST: ' + uri);

      var response = await http.post(uri, headers: headers, body: body);

      print('HTTP Response StatusCode: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      print('Erro: $e');
    }
  }

  //START PUT
  static putURL(String endPoint, Map<String, String> headers,
      Map<String, String> body) async {
    try {
      var uri = AppConfigReader.getApiHost() + endPoint;

      print('HTTP Request POST: ' + uri);

      var response = await http.put(uri, headers: headers, body: body);

      print('HTTP Response StatusCode: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');

      return response;
    } catch (e) {
      print('Erro: $e');
    }
  }
}
