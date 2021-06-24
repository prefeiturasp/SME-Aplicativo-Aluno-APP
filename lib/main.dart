import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/usuario.controller.dart';
import 'package:sme_app_aluno/controllers/terms/terms.controller.dart';
import 'package:sme_app_aluno/ioc/dependencias.ioc.dart';
import 'package:sme_app_aluno/repositories/usuario.repository.dart';
import 'package:sme_app_aluno/screens/wrapper/wrapper.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sentry/sentry.dart';

import 'controllers/autenticacao.controller.dart';
import 'controllers/auth/first_access.controller.dart';
import 'controllers/auth/recover_password.controller.dart';
import 'controllers/messages/messages.controller.dart';
import 'controllers/students/students.controller.dart';
import 'package:intl/date_symbol_data_local.dart' as date_symbol_data_local;

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.finish(taskId);
}

Future initializeAppConfig() async {
  try {
    await AppConfigReader.initialize();
  } catch (error) {
    print("Erro ao ler arquivo de configurações.");
    print("Verifique se seu projeto possui o arquivo config/app_config.json");
    print('$error');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppConfig();
  final SentryClient sentry =
      new SentryClient(dsn: AppConfigReader.getSentryDsn());
  try {} catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524),
    statusBarBrightness: Brightness.dark,
  ));

  final ioc = DependenciasIoC();

  ioc.registrarStores();
  ioc.registrarRepositories();
  ioc.registrarControllers();

  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  MyApp() {
    date_symbol_data_local.initializeDateFormatting();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StudentsController>.value(value: StudentsController()),
        Provider<MessagesController>.value(value: MessagesController()),
        Provider<RecoverPasswordController>.value(
            value: RecoverPasswordController()),
        Provider<FirstAccessController>.value(value: FirstAccessController()),
        Provider<TermsController>.value(value: TermsController()),
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SME Aplicativo do Aluno',
        theme: ThemeData(primaryColor: Color(0xFFEEC25E)),
        home: Wrapper(),
      ),
    );
  }
}
