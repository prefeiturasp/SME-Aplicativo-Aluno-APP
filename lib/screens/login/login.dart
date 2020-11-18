import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/auth/authenticate.controller.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/recover_password/recover_password.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class Login extends StatefulWidget {
  final String notice;

  Login({this.notice});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthenticateController _authenticateController;
  final UserService _userService = UserService();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _showPassword = true;
  bool _cpfIsError = false;
  bool _passwordIsError = false;

  String _cpf = '';
  String _cpfRaw = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _authenticateController = AuthenticateController();
  }

  _handleSignIn(
    String cpf,
    String password,
  ) async {
    await _authenticateController.authenticateUser(cpf, password);
    _navigateToScreen();
  }

  _navigateToScreen() async {
    if (_authenticateController.currentUser.data != null) {
      User user =
          await _userService.find(_authenticateController.currentUser.data.id);
      if (_authenticateController.currentUser.data.primeiroAcesso) {
        Nav.push(
            context,
            FirstAccess(
              id: _authenticateController.currentUser.data.id,
              cpf: _authenticateController.currentUser.data.cpf,
            ));
      } else if (user.informarCelularEmail) {
        Nav.push(
            context,
            ChangeEmailOrPhone(
              cpf: _authenticateController.currentUser.data.cpf,
              password: _password,
              userId: _authenticateController.currentUser.data.id,
            ));
      } else {
        Nav.push(
            context,
            ListStudants(
              userId: user.id,
              password: _password,
            ));
      }
    } else {
      onError();
    }
  }

  onError() {
    var snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: _authenticateController.currentUser != null
            ? Text(_authenticateController.currentUser.erros[0])
            : Text("Erro de serviço"));

    scaffoldKey.currentState.showSnackBar(snackbar);
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
                              widget.notice != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(screenHeight * 1.5),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(screenHeight * 2),
                                      child: AutoSizeText(
                                        widget.notice,
                                        maxFontSize: 18,
                                        minFontSize: 16,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: screenHeight * 4,
                              ),
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

                                    setState(() {
                                      _cpfRaw = value;
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
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  obscureText: _showPassword,
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
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
                                height: screenHeight * 3,
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Nav.push(context,
                                        RecoverPassword(input: _cpfRaw));
                                  },
                                  child: AutoSizeText(
                                    "Esqueci minha senha",
                                    maxFontSize: 14,
                                    minFontSize: 12,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Color(0xff757575),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 4,
                              ),
                              Observer(builder: (context) {
                                if (_authenticateController.isLoading) {
                                  return GFLoader(
                                    type: GFLoaderType.square,
                                    loaderColorOne: Color(0xffDE9524),
                                    loaderColorTwo: Color(0xffC65D00),
                                    loaderColorThree: Color(0xffC65D00),
                                    size: GFSize.LARGE,
                                  );
                                } else {
                                  return EAButton(
                                    text: "ENTRAR",
                                    icon: FontAwesomeIcons.chevronRight,
                                    iconColor: Color(0xffffd037),
                                    btnColor: Color(0xffd06d12),
                                    desabled: CPFValidator.isValid(_cpf) &&
                                        _password.length >= 7,
                                    onPress: () {
                                      if (_formKey.currentState.validate()) {
                                        _handleSignIn(_cpf, _password);
                                      } else {
                                        setState(() {
                                          _cpfIsError = true;
                                          _passwordIsError = true;
                                        });
                                      }
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
      ),
    );
  }
}
