import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/controllers/first_access.controller.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';
import 'package:sme_app_aluno/controllers/students.controller.dart';
import 'package:sme_app_aluno/screens/wrapper/wrapper.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/global_config.dart';
import 'package:sentry/sentry.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.finish(taskId);
}

void main() async {
  final SentryClient sentry = new SentryClient(dsn: GlobalConfig.SENTRY_DSN);
  try {
    print("DEU CERTO");
  } catch (error, stackTrace) {
    print('SENTRY | error --->, $error');
    print('SENTRY | stackTrace --->, $stackTrace');
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524), // status bar color
  ));
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  MyApp() {
    GlobalConfig.Environment = "prod";
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticateController>.value(value: AuthenticateController()),
        Provider<StudentsController>.value(value: StudentsController()),
        Provider<MessagesController>.value(value: MessagesController()),
        Provider<FirstAccessController>.value(value: FirstAccessController()),
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SME Aplicativo do Aluno',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
