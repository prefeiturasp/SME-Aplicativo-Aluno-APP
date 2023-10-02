import 'package:dio/dio.dart';
import '../interceptors/index.dart';
import '../utils/index.dart';

class ApiService {
  Dio dio = Dio();

  ApiService() {
    dio = Dio();
    dio.interceptors.add(AutenticacaoInterceptor());
    dio.options.baseUrl = AppConfigReader.getApiHost();
  }
}
