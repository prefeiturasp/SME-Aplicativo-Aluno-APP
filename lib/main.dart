import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/screens/wrapper/wrapper.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffde9524), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticateController>.value(value: AuthenticateController()),
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
