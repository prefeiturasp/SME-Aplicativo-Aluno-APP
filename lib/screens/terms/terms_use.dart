import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/terms/terms.controller.dart';
import 'terms_view.dart';

class TermsUse extends StatefulWidget {
  const TermsUse({super.key});

  @override
  TermsUseState createState() => TermsUseState();
}

class TermsUseState extends State<TermsUse> {
  final TermsController _termsController = TermsController();

  @override
  void initState() {
    super.initState();
    _termsController.fetchTermoCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        backgroundColor: const Color(0xffEEC25E),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // child: TermsView(term: _termsController.term),
        child: Observer(
          builder: (context) {
            if (_termsController.term.termosDeUso != null) {
              return TermsView(
                term: _termsController.term,
                showBtn: false,
                changeStatusTerm: () {},
                cpf: '',
              );
            } else {
              return const GFLoader(
                type: GFLoaderType.square,
                loaderColorOne: Color(0xffDE9524),
                loaderColorTwo: Color(0xffC65D00),
                loaderColorThree: Color(0xffC65D00),
                size: GFSize.LARGE,
              );
            }
          },
        ),
      ),
    );
  }
}
