import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/terms/terms.controller.dart';
import 'package:sme_app_aluno/screens/wrapper/wrapper.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/global_config.dart';
import 'package:sentry/sentry.dart';

import 'controllers/auth/authenticate.controller.dart';
import 'controllers/auth/first_access.controller.dart';
import 'controllers/auth/recover_password.controller.dart';
import 'controllers/messages/messages.controller.dart';
import 'controllers/students/students.controller.dart';
import 'package:intl/date_symbol_data_local.dart' as date_symbol_data_local;

void main() async {
  final SentryClient sentry = new SentryClient(dsn: GlobalConfig.SENTRY_DSN);
  try {} catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    GlobalConfig.Environment = "developer";
    date_symbol_data_local.initializeDateFormatting();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticateController>.value(value: AuthenticateController()),
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
