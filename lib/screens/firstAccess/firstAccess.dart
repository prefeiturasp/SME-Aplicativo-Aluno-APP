import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:sme_app_aluno/controllers/first_access.controller.dart';
import 'package:sme_app_aluno/models/user/data.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/screens/widgets/check_line/check_line.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class FirstAccess extends StatefulWidget {
  final int id;
  final bool isPhoneAndEmail;

  FirstAccess({@required this.id, @required this.isPhoneAndEmail});

  @override
  _FirstAccessState createState() => _FirstAccessState();
}

class _FirstAccessState extends State<FirstAccess> {
  final Storage _storage = Storage();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final numeric = RegExp(r"[0-9]");
  final symbols = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final upperCaseChar = RegExp(r"[^a-z]");
  final lowCaseChar = RegExp(r"[^A-Z]");
  final accents = RegExp(r"[a-zà-ú]");

  FirstAccessController _firstAccessController;

  bool _showPassword = true;
  bool _busy = false;
  bool _passwordIsError = false;
  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _firstAccessController = FirstAccessController();
  }

  _registerNewPassword(String password) async {
    setState(() {
      _busy = true;
    });
    Data data =
        await _firstAccessController.changeNewPassword(widget.id, password);
    setState(() {
      _busy = false;
    });
    if (data.ok) {
      _navigateToListStudents();
    } else {
      onError();
    }
  }

  onError() {
    var snackbar = SnackBar(
        content: _firstAccessController.data != null
            ? Text(_firstAccessController.data.erros[0])
            : Text("Erro de serviço"));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _navigateToListStudents() async {
    String cpf = await _storage.readValueStorage("current_cpf");
    String token = await _storage.readValueStorage("token");
    if (widget.isPhoneAndEmail) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeEmailOrPhone(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListStudants(
              cpf: cpf,
              token: token,
              password: _password,
            ),
          ));
    }
  }

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
                      autovalidate: true,
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
                                  obscureText: _showPassword,
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Nova senha',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text),
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
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                obscureText: _showPassword,
                                onChanged: (value) {
                                  setState(() {
                                    _confirmPassword = value;
                                  });
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

                                  labelText: 'Confirmar a nova senha',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    if (value != _password) {
                                      return "Senhas não correspondem";
                                    }
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.text,
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
                                    checked: upperCaseChar.hasMatch(_password)),
                                CheckLine(
                                    screenHeight: screenHeight,
                                    text: "Uma letra minúscula",
                                    checked: lowCaseChar.hasMatch(_password)),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text:
                                      "Um algarismo (número) ou um símbolo (caractere especial)",
                                  checked: (numeric.hasMatch(_password) ||
                                      symbols.hasMatch(_password)),
                                ),
                                CheckLine(
                                  screenHeight: screenHeight,
                                  text:
                                      "Não pode permitir caracteres acentuados",
                                  checked: accents.hasMatch(_password),
                                ),
                                CheckLine(
                                    screenHeight: screenHeight,
                                    text:
                                        "Deve ter no mínimo 8 e no máximo 12 caracteres.",
                                    checked: _password.length >= 8 &&
                                        _password.length <= 12),
                              ],
                            ),
                            !_busy
                                ? EAButton(
                                    text: "CADASTRAR",
                                    icon: FontAwesomeIcons.chevronRight,
                                    iconColor: Color(0xffffd037),
                                    btnColor: Color(0xffd06d12),
                                    desabled: (_password.isNotEmpty &&
                                            _confirmPassword.isNotEmpty) &&
                                        (_confirmPassword == _password),
                                    onPress: () {
                                      _registerNewPassword(_password);
                                    },
                                  )
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
