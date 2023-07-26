import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../stores/index.dart';

class AutenticacaoInterceptor extends Interceptor {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (usuarioStore.token.isNotEmpty) {
      final headerToken = 'Bearer ${usuarioStore.token}';
      options.headers['Authorization'] = headerToken;
      handler.next(options);
    }
  }
}
