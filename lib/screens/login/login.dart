import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = true;
  bool _autoValidate = false;
  String _cpf = '';
  String _dataNnascimentoAluno = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Scaffold(
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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: screenHeight * 8, bottom: screenHeight * 6),
                      width: double.infinity,
                      child: Image.asset("assets/images/logo_app.png"),
                    ),
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
                                        color: _cpf.isEmpty
                                            ? Color(0xff8b8b8b)
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _cpfController,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: 'Usuário',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _cpf = _cpfController.text;
                                  });
                                  _formKey.currentState.validate();
                                },
                                validator: (_) {
                                  if (_cpf.isEmpty) {
                                    return 'Campo obrigatório, não pode ficar em branco.';
                                  }

                                  if (_cpf.length == 14 &&
                                      !CPFValidator.isValid(_cpf)) {
                                    return 'CPF inválido';
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  CpfInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            AutoSizeText(
                              "Digite o CPF do resposável",
                              maxFontSize: 14,
                              minFontSize: 12,
                              style: TextStyle(color: Color(0xff979797)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: screenHeight * 5),
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: _dataNnascimentoAluno.isEmpty
                                            ? Color(0xff8b8b8b)
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                obscureText: _showPassword,
                                onChanged: (value) {
                                  setState(() {
                                    _dataNnascimentoAluno =
                                        _passwordController.text;
                                  });
                                  _formKey.currentState.validate();
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _showPassword
                                        ? Icon(FontAwesomeIcons.eye)
                                        : Icon(FontAwesomeIcons.eyeSlash),
                                    color: Color(0xff6e6e6e),
                                    iconSize: screenHeight * 3.0,
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                  ),
                                  labelText: 'Senha',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (_) {
                                  if (_dataNnascimentoAluno.isEmpty) {
                                    return 'Campo obrigatório, não pode ficar em branco.';
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  DataInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            AutoSizeText(
                              "Digite a data de nacimento do aluno dd/mm/aaaa",
                              maxFontSize: 14,
                              minFontSize: 12,
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 7,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: screenHeight * 7,
                              decoration: BoxDecoration(
                                  color: Color(0xffd06d12),
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 3.5)),
                              child: FlatButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListStudants()));
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                ),
                              ),
                            )
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
