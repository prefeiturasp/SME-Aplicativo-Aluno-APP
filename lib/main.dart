import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/terms/terms.controller.dart';
import 'package:sme_app_aluno/ioc/dependencias.ioc.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'controllers/auth/first_access.controller.dart';
import 'controllers/auth/recover_password.controller.dart';
import 'controllers/messages/messages.controller.dart';
import 'package:intl/date_symbol_data_local.dart' as date_symbol_data_local;

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.finish(taskId);
}

Future initializeAppConfig() async {
  try {
    await AppConfigReader.initialize();
  } catch (error) {
    log("Erro ao ler arquivo de configurações.");
    log("Verifique se seu projeto possui o arquivo config/app_config.json");
    log('$error');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppConfig();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524),
    statusBarBrightness: Brightness.dark,
  ));

  final ioc = DependenciasIoC();

  ioc.registrarStores();
  ioc.registrarServicos();
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
        Provider<MessagesController>.value(value: MessagesController()),
        Provider<RecoverPasswordController>.value(value: RecoverPasswordController()),
        Provider<FirstAccessController>.value(value: FirstAccessController()),
        Provider<TermsController>.value(value: TermsController()),
        StreamProvider<ConnectivityStatus>(
            initialData: ConnectivityStatus.Celular,
            create: (context) => ConnectivityService().connectionStatusController.stream),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SME Aplicativo do Aluno',
        theme: ThemeData(primaryColor: Color(0xFFEEC25E)),
        home: FluxoInicialView(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
