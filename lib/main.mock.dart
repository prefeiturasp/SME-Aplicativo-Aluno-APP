import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/controllers/students.controller.dart';
import 'package:sme_app_aluno/screens/wrapper/wrapper.dart';
import 'package:sme_app_aluno/utils/global_config.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  BackgroundFetch.finish(taskId);
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524), // status bar color
  ));
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  MyApp() {
    GlobalConfig.Environment = "test";
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticateController>.value(value: AuthenticateController()),
        Provider<StudentsController>.value(value: StudentsController()),
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
