import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sme_app_aluno/controllers/terms/terms.controller.dart';
import 'package:sme_app_aluno/screens/terms/terms_view.dart';

class TermsUse extends StatefulWidget {
  @override
  _TermsUseState createState() => _TermsUseState();
}

class _TermsUseState extends State<TermsUse> {
  TermsController _termsController;

  @override
  void initState() {
    super.initState();
    _termsController = TermsController();
    _termsController.fetchTermoCurrentUser();
  }

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
        // child: TermsView(term: _termsController.term),
        child: Observer(builder: (context) {
          if (_termsController.term != null &&
              _termsController.term.termosDeUso != null) {
            return TermsView(term: _termsController.term, showBtn: false);
          } else {
            return GFLoader(
              type: GFLoaderType.square,
              loaderColorOne: Color(0xffDE9524),
              loaderColorTwo: Color(0xffC65D00),
              loaderColorThree: Color(0xffC65D00),
              size: GFSize.LARGE,
            );
          }
        }),
      ),
    );
  }
}
