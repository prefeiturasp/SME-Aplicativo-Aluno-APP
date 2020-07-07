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
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
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

  bool _cpfIsError = false;
  bool _passwordIsError = false;

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
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('current_name');
    prefs.remove('current_cpf');
    prefs.remove('current_email');
    prefs.remove('token');
    prefs.remove('current_password');
    prefs.remove('dispositivo_id');
    _authenticateController.clearCurrentUser();
    setState(() {
      busy = true;
    });
    _storage.insertString("current_password", password);
    _authenticateController.authenticateUser(cpf, password, false).then((data) {
      onSuccess();
    }).catchError((err) {
      onError();
    }).whenComplete(() {
      onComplete();
    });
  }

  _navigateToScreen() async {
    bool isData = await _storage.containsKey('current_cpf');
    String cpf = await _storage.readValueStorage("current_cpf");
    String token = await _storage.readValueStorage("token");
    String password = await _storage.readValueStorage("current_password");

    if (isData) {
      if (_authenticateController.currentUser.data.primeiroAcesso) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FirstAccess(
                      id: _authenticateController.currentUser.data.id,
                      isPhoneAndEmail: _authenticateController
                          .currentUser.data.informarCelularEmail,
                    )));
      } else if (_authenticateController
          .currentUser.data.informarCelularEmail) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangeEmailOrPhone()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListStudants(
                cpf: cpf,
                token: token,
                password: password,
              ),
            ));
      }
    } else {
      onError();
    }
  }

  onSuccess() async {
    _navigateToScreen();
  }

  onError() {
    var snackbar = SnackBar(
        content: _authenticateController.currentUser != null
            ? Text(_authenticateController.currentUser.erros[0])
            : Text("Erro de serviço"));

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
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
                            top: screenHeight * 8, bottom: screenHeight * 6),
                        child:
                            Image.asset("assets/images/Logo_escola_aqui.png"),
                      ),
                      Form(
                        autovalidate: true,
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.only(left: screenHeight * 2),
                                decoration: BoxDecoration(
                                  color: Color(0xfff0f0f0),
                                  border: Border(
                                      bottom: BorderSide(
                                          color: _cpfIsError
                                              ? Colors.red
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
                                    if (value.isNotEmpty) {
                                      if (!CPFValidator.isValid(_cpf)) {
                                        return 'CPF inválido';
                                      }
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
                                padding:
                                    EdgeInsets.only(left: screenHeight * 2),
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
                                  obscureText: _showPassword,
                                  onChanged: (value) {
                                    setState(() {
                                      _dataNnascimentoAluno =
                                          _passwordController.text;
                                      // _passwordController.text.replaceAll(
                                      //     new RegExp(r'[^\w\s]+'), '');
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if (value.length <= 7) {
                                        return 'Sua senha deve conter no mínimo 8 caracteres';
                                      }
                                    }

                                    return null;
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
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 1,
                              ),
                              AutoSizeText(
                                "Digite a sua senha. Caso você ainda não tenha uma senha pessoal informe a data de nascimento do aluno no padrão ddmmaaaa.",
                                maxFontSize: 14,
                                minFontSize: 12,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Color(0xff979797),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 7,
                              ),
                              !busy
                                  ? EAButton(
                                      text: "ENTRAR",
                                      icon: FontAwesomeIcons.chevronRight,
                                      iconColor: Color(0xffffd037),
                                      btnColor: Color(0xffd06d12),
                                      desabled: CPFValidator.isValid(_cpf) &&
                                          _dataNnascimentoAluno.length >= 7,
                                      onPress: () {
                                        if (_formKey.currentState.validate()) {
                                          _handleSignIn(
                                              _cpf, _dataNnascimentoAluno);
                                        } else {
                                          setState(() {
                                            _cpfIsError = true;
                                            _passwordIsError = true;
                                          });
                                        }
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
      ),
    );
  }
}
