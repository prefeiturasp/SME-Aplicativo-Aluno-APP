import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/stores/index.dart';

class AutenticacaoInterceptor extends Interceptor {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (usuarioStore.token.isNotEmpty) {
      var headerToken = 'Bearer ${usuarioStore.token}';
      options.headers['Authorization'] = headerToken;
      handler.next(options);
    }
  }
}
