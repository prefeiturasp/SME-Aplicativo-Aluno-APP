import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/utils/size_config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60, bottom: 60),
                width: double.infinity,
                child: Image.asset("assets/images/logo_app.png"),
              ),
              Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Color(0xfff0f0f0),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xff8b8b8b), width: 2.0)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Usuário',
                            labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                            // hintText: "Digite o CPF do responsável",
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        "Digite o CPF do resposável",
                        maxFontSize: 14,
                        minFontSize: 12,
                        style: TextStyle(color: Color(0xff979797)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Color(0xfff0f0f0),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xff8b8b8b), width: 2.0)),
                        ),
                        child: TextFormField(
                          obscureText: _showPassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: _showPassword
                                  ? Icon(FontAwesomeIcons.eye)
                                  : Icon(FontAwesomeIcons.eyeSlash),
                              color: Color(0xff6e6e6e),
                              iconSize: 18,
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            labelText: 'Senha',
                            labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                            // hintText: "Data de nascimento do aluno",
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            DataInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                        height: 50.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xffd06d12),
                            borderRadius: BorderRadius.circular(25)),
                        child: FlatButton(
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "ENTRAR",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                FontAwesomeIcons.chevronRight,
                                color: Color(0xffffd037),
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
