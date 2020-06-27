import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/controllers/first_access.controller.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class ChangeEmailOrPhone extends StatefulWidget {
  @override
  _ChangeEmailOrPhoneState createState() => _ChangeEmailOrPhoneState();
}

class _ChangeEmailOrPhoneState extends State<ChangeEmailOrPhone> {
  final Storage _storage = Storage();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  FirstAccessController _firstAccessController;

  ReactionDisposer disposer;

  bool _busy = false;

  String _email = '';
  bool _emailError = false;

  String _phone = '';
  bool _phoneError = false;

  @override
  void initState() {
    super.initState();
    _firstAccessController = FirstAccessController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer =
        reaction((_) => _firstAccessController.dataEmailOrPhone.ok, (isOk) {
      if (isOk) {
        _navigateToListStudents();
      } else {
        onError();
      }
    });
  }

  _changeEmail(String newEmail) async {
    int _id = await _storage.readValueIntStorage("current_user_id");
    setState(() {
      _busy = true;
    });
    await _firstAccessController.changeEmail(_id, newEmail);
    setState(() {
      _busy = false;
    });
  }

  _changePhone(String newPhone) async {
    int _id = await _storage.readValueIntStorage("current_user_id");
    setState(() {
      _busy = true;
    });
    await _firstAccessController.changePhone(_id, newPhone);
    setState(() {
      _busy = false;
    });
  }

  onError() {
    var snackbar = SnackBar(
        content: _firstAccessController.data != null
            ? Text(_firstAccessController.data.erros[0])
            : Text("Erro de serviço"));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _navigateToListStudents() async {
    String _cpf = await _storage.readValueStorage("current_cpf");
    String _token = await _storage.readValueStorage("token");
    String _password = await _storage.readValueStorage("password");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListStudants(
            cpf: _cpf,
            token: _token,
            password: _password,
          ),
        ));
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
                          "Falta pouco! Cadastre agora um novo email ou um número de celular para que possamos nos comunicar!",
                          maxFontSize: 18,
                          minFontSize: 16,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575),
                          ),
                        )),
                    Form(
                      key: _formKey,
                      // autovalidate: true,
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
                                        color: _emailError
                                            ? Colors.red
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                autovalidate:
                                    _phone.isEmpty && _email.isNotEmpty,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (_phone.isEmpty &&
                                      !EmailValidator.validate(_email)) {
                                    return 'Email inválido';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            AutoSizeText(
                              "Digite o email cadastrado no sistema",
                              maxFontSize: 14,
                              minFontSize: 12,
                              maxLines: 3,
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: screenHeight * 3,
                                    bottom: screenHeight * 3),
                                child: AutoSizeText(
                                  "Ou se preferir, insira seu telefone",
                                  maxFontSize: 18,
                                  minFontSize: 16,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff757575),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: _phoneError
                                            ? Colors.red
                                            : Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                autovalidate:
                                    _email.isEmpty && _phone.isNotEmpty,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                onChanged: (value) {
                                  setState(() {
                                    _phone = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Telefone',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (_email.isEmpty && value.length != 15) {
                                    return 'Telefone inválido';
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(),
                                  LengthLimitingTextInputFormatter(15)
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            AutoSizeText(
                              "(DDD) Número do telefone (sem espaços)",
                              maxFontSize: 14,
                              minFontSize: 12,
                              maxLines: 3,
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 1,
                            ),
                            InfoBox(
                              icon: FontAwesomeIcons.exclamationTriangle,
                              content: <Widget>[
                                AutoSizeText(
                                  "O fornecimento de um dos campos é obrigatório. Estes contatos serão usados para a recuperação da sua senha",
                                  maxFontSize: 18,
                                  minFontSize: 16,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffff0000)),
                                ),
                              ],
                            ),
                            !_busy
                                ? EAButton(
                                    text: "CADASTRAR",
                                    icon: FontAwesomeIcons.chevronRight,
                                    iconColor: Color(0xffffd037),
                                    btnColor: Color(0xffd06d12),
                                    desabled: EmailValidator.validate(_email) ||
                                        _phone.length == 15,
                                    onPress: () {
                                      if ((_phone.isEmpty &&
                                              EmailValidator.validate(
                                                  _email)) ||
                                          (_email.isEmpty &&
                                              _phone.length == 15)) {
                                        if (_phone.isNotEmpty) {
                                          _changePhone(_phone);
                                        } else {
                                          _changeEmail(_email);
                                        }
                                      } else {
                                        setState(() {
                                          _emailError = true;
                                          _phoneError = true;
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
    );
  }
}
