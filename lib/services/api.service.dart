import 'package:dio/dio.dart';
import 'package:sme_app_aluno/interceptors/index.dart';
import 'package:sme_app_aluno/utils/index.dart';

class ApiService {
  Dio dio = new Dio();

  ApiService() {
    dio = new Dio();
    dio.interceptors.add(new AutenticacaoInterceptor());
    dio.options.baseUrl = AppConfigReader.getApiHost();
  }
}
