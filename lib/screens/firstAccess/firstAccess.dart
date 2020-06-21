import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/screens/widgets/check_line/check_line.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/utils/storage.dart';
import 'package:string_validator/string_validator.dart';

class FirstAccess extends StatefulWidget {
  @override
  _FirstAccessState createState() => _FirstAccessState();
}

class _FirstAccessState extends State<FirstAccess> {
  AuthenticateController _authenticateController;

  final Storage _storage = Storage();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showPassword = true;
  bool busy = false;
  bool _cpfIsError = false;
  bool _passwordIsError = false;
  String _cpf = '';
  String _dataNnascimentoAluno = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: screenHeight * 36,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: screenHeight * 8, bottom: screenHeight * 2),
                      child: Image.asset("assets/images/Logo_escola_aqui.png"),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 3),
                        child: AutoSizeText(
                          "Primeiro Acesso! Cadastre uma nova senha",
                          maxFontSize: 18,
                          minFontSize: 16,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff757575)),
                        )),
                    Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: _passwordIsError
                                            ? Colors.red
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Nova senha',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: screenHeight * 5),
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: _passwordIsError
                                            ? Colors.red
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                obscureText: _showPassword,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Confirmar a nova senha',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (_) {
                                  if (_dataNnascimentoAluno.isEmpty)
                                    return 'Campo obrigatório';

                                  return null;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            InfoBox(
                              icon: FontAwesomeIcons.exclamationTriangle,
                              content: <Widget>[
                                AutoSizeText(
                                  "Requisitos para sua nova senha!",
                                  maxFontSize: 18,
                                  minFontSize: 16,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffff0000)),
                                ),
                                SizedBox(
                                  height: screenHeight * 2,
                                ),
                                CheckLine(
                                    screenHeight: screenHeight,
                                    text: "Uma letra maiúscula",
                                    checked:
                                        isUppercase(_passwordController.text)),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text: "Uma letra minúscula",
                                ),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text:
                                      "Um algarismo (número) ou um símbolo (caractere especial)",
                                ),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text:
                                      "Não pode permitir caracteres acentuados",
                                ),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text:
                                      "Deve ter no mínimo 8 e no máximo 12 caracteres.",
                                ),
                              ],
                            ),
                            !busy
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: screenHeight * 6,
                                    decoration: BoxDecoration(
                                        color: Color(0xffd06d12),
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 3)),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                          } else {
                                            setState(() {
                                              _cpfIsError = true;
                                              _passwordIsError = true;
                                            });
                                          }
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            AutoSizeText(
                                              "ENTRAR",
                                              maxFontSize: 16,
                                              minFontSize: 14,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: screenHeight * 3,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.chevronRight,
                                              color: Color(0xffffd037),
                                              size: screenHeight * 3,
                                            )
                                          ],
                                        )))
                                : GFLoader(
                                    type: GFLoaderType.square,
                                    loaderColorOne: Color(0xffDE9524),
                                    loaderColorTwo: Color(0xffC65D00),
                                    loaderColorThree: Color(0xffC65D00),
                                    size: GFSize.LARGE,
                                  ),
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
