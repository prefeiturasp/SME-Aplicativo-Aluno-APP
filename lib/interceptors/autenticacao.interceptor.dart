import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/stores/index.dart';

class AutenticacaoInterceptor extends Interceptor {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future onRequest(RequestOptions options) {
    if (usuarioStore.token != null) {
      var headerToken = 'Bearer ${usuarioStore.token}';
      options.headers['Authorization'] = headerToken;
    }

    return super.onRequest(options);
  }
}
