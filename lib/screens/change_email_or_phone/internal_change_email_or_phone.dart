import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/controllers/first_access.controller.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class InternalChangeEmailOrPhone extends StatefulWidget {
  @override
  _InternalChangeEmailOrPhoneState createState() =>
      _InternalChangeEmailOrPhoneState();
}

class _InternalChangeEmailOrPhoneState
    extends State<InternalChangeEmailOrPhone> {
  final Storage _storage = Storage();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailController;
  TextEditingController _phoneController;
  FirstAccessController _firstAccessController;

  ReactionDisposer disposer;

  bool _busy = false;
  String _email = '';
  String _phone = '';

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
        _navigateToScreen();
      } else {
        onError();
      }
    });
  }

  fetchChangeEmailOrPhone(String email, String phone) async {
    setState(() {
      _busy = true;
    });
    await _firstAccessController
        .changeEmailAndPhone(email, phone, true)
        .then((data) {
      _navigateToScreen();
    });
    setState(() {
      _busy = false;
    });
  }

  onError() {
    var snackbar = SnackBar(
        content: _firstAccessController.data != null
            ? Text(_firstAccessController.data.erros[0])
            : Text("Erro de serviço"));

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _navigateToScreen() async {
    if (_firstAccessController.data.ok) {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'PARABÉNS',
        desc: 'Dados alterados com sucesso!',
        btnOkText: "CONTINUAR",
        btnOkOnPress: () {
          Navigator.of(context).pop(true);
        },
      )..show();
    } else {
      onError();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    // _loadEmailAndCelular();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Alterar Dados"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
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
                            bottom: screenHeight * 4, top: screenHeight * 3),
                        child: AutoSizeText(
                          "Alterar e-mail ou senha",
                          maxFontSize: 18,
                          minFontSize: 16,
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
                                        color: Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                autovalidate:
                                    _phone.isEmpty && _email.isNotEmpty,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                  _emailController.text = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'E-mail',
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
                                    return 'E-mail inválido';
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
                              "Digite o E-mail cadastrado no sistema",
                              maxFontSize: 14,
                              minFontSize: 12,
                              maxLines: 3,
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              margin: EdgeInsets.only(
                                top: screenHeight * 3,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD06D12),
                                        width: screenHeight * 0.39)),
                              ),
                              child: TextFormField(
                                controller: _phoneController,
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
                                  labelText: 'Número de Telefone',
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
                              height: screenHeight * 4,
                            ),
                            !_busy
                                ? EAButton(
                                    text: "ATUALIZAR",
                                    icon: FontAwesomeIcons.chevronRight,
                                    iconColor: Color(0xffffd037),
                                    btnColor: Color(0xffd06d12),
                                    desabled: EmailValidator.validate(_email) ||
                                        _phone.length == 15,
                                    onPress: () {
                                      fetchChangeEmailOrPhone(_email, _phone);
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
            ],
          ),
        ),
      ),
    );
  }
}
