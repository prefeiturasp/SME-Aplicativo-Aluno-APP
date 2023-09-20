// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

class SalvarLogSentry {
  void registrarErro(String mensagemErro,String? stackTrace) {
    GetIt.I.get<SentryClient>().captureException(mensagemErro,stackTrace:stackTrace);
  }
}
