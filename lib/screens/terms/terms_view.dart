import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/auth/authenticate.controller.dart';
import 'package:sme_app_aluno/controllers/terms/terms.controller.dart';

class TermsView extends StatefulWidget {
  final bool button;
  final Function changeStatusTerm;
  final String cpf;
  TermsView({this.button = false, this.changeStatusTerm,  this.cpf});

  @override
  _TermsViewState createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  TermsController _termsController;
  AuthenticateController _authenticateController;
  final ScrollController _controller = new ScrollController();
  var reachEnd = false;


  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        reachEnd = false;
      });
    }
  }
loading() async{
  _authenticateController = AuthenticateController();
  _termsController = TermsController();
  _termsController.fetchTermo(widget.cpf);
}

  @override
  void initState() {
    _controller.addListener(_listener);
    loading();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: widget.button == true ? 30.0 : 0.0,
        bottom: widget.button == true ? 30.0 : 0.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            controller: _controller,
            children: <Widget>[
              Observer(builder: (context) {
                if (_termsController.term == null || _termsController.loading) {
                  return GFLoader(
                    type: GFLoaderType.square,
                    loaderColorOne: Color(0xffDE9524),
                    loaderColorTwo: Color(0xffC65D00),
                    loaderColorThree: Color(0xffC65D00),
                    size: GFSize.LARGE,
                  );
                } else {
                  return Column(
                    children: [
                      AutoSizeText(
                        'Termos e condições de uso',
                        minFontSize: 14,
                        maxFontSize: 16,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Html(data: _termsController.term.termosDeUso),
                      AutoSizeText(
                        'Política de privacidade',
                        minFontSize: 14,
                        maxFontSize: 16,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Html(data: _termsController.term.politicaDePrivacidade),
                    ],
                  );
                }
              })
            ],
          ),
        ),
      ),
      widget.button == true
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: FlatButton(
                    onPressed: reachEnd
                        ? widget.changeStatusTerm
                        : null,
                    child: AutoSizeText(
                      'Aceitar todos os termos',
                      maxFontSize: 16,
                      minFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ))
                ],
              ))
          : SizedBox.shrink(),
      widget.button == true
          ? Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 1.0,
                      )
                    ]),
                height: 8,
                width: MediaQuery.of(context).size.width - 200,
              ))
          : SizedBox.shrink()
    ]);
  }
}
