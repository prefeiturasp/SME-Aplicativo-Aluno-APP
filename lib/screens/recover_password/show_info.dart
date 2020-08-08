import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/recover_password.controller.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/utils/navigator.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class ShowInfo extends StatefulWidget {
  final String email;
  final bool hasToken;

  ShowInfo({this.email, this.hasToken = false});

  @override
  _ShowInfoState createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo> {
  String _token = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    final _recoverPasswordController =
        Provider.of<RecoverPasswordController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Resumo do Estudante"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF36621),
          ),
          onPressed: () => Nav.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenHeight * 2.5, right: screenHeight * 2.5),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: screenHeight * 36,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: screenHeight * 6),
                      child: Image.asset("assets/images/Logo_escola_aqui.png"),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            bottom: screenHeight * 6,
                            left: screenHeight * 6,
                            right: screenHeight * 6),
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              "As orientações para recuperação de \n senha foram enviados para",
                              textAlign: TextAlign.center,
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 5,
                              style: TextStyle(
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.bold),
                            ),
                            widget.hasToken
                                ? Container()
                                : SizedBox(
                                    height: screenHeight * 3,
                                  ),
                            widget.hasToken
                                ? Container()
                                : AutoSizeText(
                                    StringSupport.replaceEmailSecurity(
                                        widget.email, 3),
                                    textAlign: TextAlign.center,
                                    maxFontSize: 16,
                                    minFontSize: 14,
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Color(0xffD16C12),
                                        fontWeight: FontWeight.bold),
                                  ),
                            SizedBox(
                              height: screenHeight * 3,
                            ),
                            AutoSizeText(
                              "verifique sua caixa de entrada!",
                              textAlign: TextAlign.center,
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 5,
                              style: TextStyle(
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    Form(
                      autovalidate: true,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: screenHeight * 25,
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: 'Código',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _token = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 6,
                            ),
                            Observer(builder: (context) {
                              if (_recoverPasswordController.loading) {
                                return GFLoader(
                                  type: GFLoaderType.square,
                                  loaderColorOne: Color(0xffDE9524),
                                  loaderColorTwo: Color(0xffC65D00),
                                  loaderColorThree: Color(0xffC65D00),
                                  size: GFSize.LARGE,
                                );
                              } else {
                                return EAButton(
                                  text: "CONTINUAR",
                                  icon: FontAwesomeIcons.chevronRight,
                                  iconColor: Color(0xffffd037),
                                  btnColor: Color(0xffd06d12),
                                  desabled: _token.length == 8,
                                  onPress: () {
                                    _recoverPasswordController
                                        .validateToken(_token);
                                  },
                                );
                              }
                            }),
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 6,
                margin: EdgeInsets.only(top: 70),
                child: Image.asset("assets/images/logo_sme.png",
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
