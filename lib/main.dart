import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart' as date_symbol_data_local;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/auth/first_access.controller.dart';
import 'controllers/auth/recover_password.controller.dart';
import 'controllers/messages/messages.controller.dart';
import 'controllers/terms/terms.controller.dart';
import 'ioc/dependencias.ioc.dart';
import 'ui/views/fluxo_inicial.view.dart';
import 'utils/app_config_reader.dart';
import 'utils/conection.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.finish(taskId);
}

Future initializeAppConfig() async {
  try {
    await AppConfigReader.initialize();
    await initializeiOS();
  } catch (error) {
    log('Erro ao ler arquivo de configurações.');
    log('Verifique se seu projeto possui o arquivo config/app_config.json');
    log('$error');
  }
}

Future<void> initializeiOS() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}

Future<void> obterVersaoApp() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('versaoApp', jsonEncode(packageInfo.version));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  obterVersaoApp();
  await Firebase.initializeApp();
  await initializeAppConfig();
  await Future.delayed(const Duration(seconds: 3));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xffde9524),
      statusBarBrightness: Brightness.dark,
    ),
  );

  final ioc = DependenciasIoC();

  ioc.registrarStores();
  ioc.registrarServicos();
  ioc.registrarRepositories();
  ioc.registrarControllers();

  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    date_symbol_data_local.initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MessagesController>.value(value: MessagesController()),
        Provider<RecoverPasswordController>.value(value: RecoverPasswordController()),
        Provider<FirstAccessController>.value(value: FirstAccessController()),
        Provider<TermsController>.value(value: TermsController()),
        StreamProvider<ConnectivityStatus>(
          initialData: ConnectivityStatus.celular,
          create: (context) => ConnectivityService().connectionStatusController.stream,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SME Aplicativo do Aluno',
        color: const Color(0xffEEC25E),
        theme: ThemeData(
          primaryColor: const Color(0xFFEEC25E),
          useMaterial3: false,
        ),
        home: const FluxoInicialView(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
