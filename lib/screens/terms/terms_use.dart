import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/terms/terms_view.dart';

class TermsUse extends StatefulWidget {
  @override
  _TermsUseState createState() => _TermsUseState();
}

class _TermsUseState extends State<TermsUse> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text("Termos de Uso"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TermsView(button: false,),
      ),
    );
  }
}
