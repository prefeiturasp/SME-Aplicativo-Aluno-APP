import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:sme_app_aluno/controllers/auth/recover_password.controller.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/screens/widgets/check_line/check_line.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/navigator.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class RedefinePassword extends StatefulWidget {
  final String cpf;
  final String token;

  RedefinePassword({@required this.cpf, @required this.token});

  @override
  _RedefinePasswordState createState() => _RedefinePasswordState();
}

class _RedefinePasswordState extends State<RedefinePassword> {
  final Storage _storage = Storage();
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final numeric = RegExp(r"[0-9]");
  final symbols = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final upperCaseChar = RegExp(r"[A-Z]");
  final lowCaseChar = RegExp(r"[a-z]");
  final accentLowcase = RegExp(r'[à-ú]');
  final accentUppercase = RegExp(r'[À-Ú]');
  final spaceNull = RegExp(r"[/\s/]");

  RecoverPasswordController _recoverPasswordController;

  bool _showNewPassword = true;
  bool _showConfirmPassword = true;

  bool _passwordIsError = false;

  String _oldPassword = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _recoverPasswordController = RecoverPasswordController();
  }

  _navigateToScreen() async {
    if (_recoverPasswordController.dataUser.ok) {
      final User user =
          await _userService.find(_recoverPasswordController.dataUser.data.id);
      Nav.push(
        context,
        ListStudants(
          userId: user.id,
          password: _password,
        ),
      );
    } else {
      onError();
    }
  }

  _changePassword(String password, String token) async {
    _storage.removeAllValues();
    await _recoverPasswordController.redefinePassword(password, token);
    _navigateToScreen();
  }

  onError() {
    var snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: _recoverPasswordController.dataUser != null
            ? Text(_recoverPasswordController.dataUser.erros[0])
            : Text("Erro de serviço"));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text(
                "Você não confirmou as suas alterações, deseja descartá-las?"),
            actions: <Widget>[
              FlatButton(
                child: Text("SIM"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text("NÃO"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Alteração de senha"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: WillPopScope(
        onWillPop: (_password.isNotEmpty ||
                _oldPassword.isNotEmpty ||
                _confirmPassword.isNotEmpty)
            ? _onBackPress
            : null,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              bottom: screenHeight * 3, top: screenHeight * 3),
                          child: AutoSizeText(
                            "Confirme a nova senha abaixo",
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
                                          color: _passwordIsError
                                              ? Colors.red
                                              : Color(0xffD06D12),
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                    obscureText: _showNewPassword,
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.w600),
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isNotEmpty) {
                                        if (spaceNull.hasMatch(value)) {
                                          return "Senha não pode ter espaço em branco";
                                        }
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: _showNewPassword
                                            ? Icon(FontAwesomeIcons.eye)
                                            : Icon(FontAwesomeIcons.eyeSlash),
                                        color: Color(0xff6e6e6e),
                                        iconSize: screenHeight * 3.0,
                                        onPressed: () {
                                          setState(() {
                                            _showNewPassword =
                                                !_showNewPassword;
                                          });
                                        },
                                      ),
                                      labelText: 'Nova senha',
                                      labelStyle:
                                          TextStyle(color: Color(0xff8e8e8e)),
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.w700),
                                      // hintText: "Data de nascimento do aluno",
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text),
                              ),
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
                                          color: _passwordIsError
                                              ? Colors.red
                                              : Color(0xffD06D12),
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  obscureText: _showConfirmPassword,
                                  onChanged: (value) {
                                    setState(() {
                                      _confirmPassword = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: _showConfirmPassword
                                          ? Icon(FontAwesomeIcons.eye)
                                          : Icon(FontAwesomeIcons.eyeSlash),
                                      color: Color(0xff6e6e6e),
                                      iconSize: screenHeight * 3.0,
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword =
                                              !_showConfirmPassword;
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
                                        color: Color(0xff717171)),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 2,
                                  ),
                                  CheckLine(
                                      screenHeight: screenHeight,
                                      text: "Uma letra maiúscula",
                                      checked:
                                          upperCaseChar.hasMatch(_password)),
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
                                    checked: _password.length > 0 &&
                                        !accentUppercase.hasMatch(_password) &&
                                        !accentLowcase.hasMatch(_password),
                                  ),
                                  CheckLine(
                                      screenHeight: screenHeight,
                                      text:
                                          "Deve ter no mínimo 8 e no máximo 12 caracteres.",
                                      checked: _password.length >= 8 &&
                                          _password.length <= 12),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 3,
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
                                    text: "CONFIRMAR ALTERAÇÃO",
                                    icon: FontAwesomeIcons.chevronRight,
                                    iconColor: Color(0xffffd037),
                                    btnColor: Color(0xffd06d12),
                                    desabled: (_password.isNotEmpty &&
                                            _confirmPassword.isNotEmpty &&
                                            !spaceNull.hasMatch(_password)) &&
                                        (_confirmPassword == _password),
                                    onPress: () {
                                      _changePassword(_password, widget.token);
                                    },
                                  );
                                }
                              })
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
