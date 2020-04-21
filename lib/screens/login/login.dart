import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthenticateController _authenticateController;
  final Storage _storage = Storage();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = true;
  bool busy = false;

  String _cpf = '';
  String _dataNnascimentoAluno = '';

  @override
  void initState() {
    super.initState();
    _authenticateController = AuthenticateController();
  }

  _handleSignIn(
    String cpf,
    String password,
  ) {
    _storage.removeAllValues();
    _authenticateController.clearCurrentUser();
    setState(() {
      busy = true;
    });
    _storage.insertString("current_password", password);
    _authenticateController.authenticateUser(cpf, password).then((data) {
      onSuccess();
    }).catchError((err) {
      onError();
    }).whenComplete(() {
      onComplete();
    });
  }

  onSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isData = prefs.containsKey('current_cpf');
    if (isData) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListStudants(
            cpf: prefs.getString("current_cpf") ?? "",
            token: prefs.getString("token") ?? "",
            password: prefs.getString("current_password") ?? "",
          ),
        ),
      );
    } else {
      onError();
    }
  }

  onError() {
    var snackbar = SnackBar(
        content: _authenticateController.currentUser != null
            ? Text(_authenticateController.currentUser.erros[0])
            : Text("dddd"));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  onComplete() {
    setState(() {
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    // var _authenticateController =
    //     Provider.of<AuthenticateController>(context, listen: false);

    // // _authenticateController.currentUser.erros[0].isNotEmpty

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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: screenHeight * 8, bottom: screenHeight * 6),
                      width: double.infinity,
                      child: Image.asset("assets/images/logo_app.png"),
                    ),
                    Form(
                      autovalidate: true,
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
                                    _cpf = CPFValidator.strip(value);
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo obrigatório, não pode ficar em branco.';
                                  }

                                  if (!CPFValidator.isValid(_cpf)) {
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
                              "Digite o CPF do responsável",
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
                                        _passwordController.text.replaceAll(
                                            new RegExp(r'[^\w\s]+'), '');
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
                                  labelText: 'Senha',
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
                            AutoSizeText(
                              "Digite a data de nascimento do aluno ddmmaaaa",
                              maxFontSize: 14,
                              minFontSize: 12,
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 7,
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
                                            _handleSignIn(
                                                _cpf, _dataNnascimentoAluno);
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
