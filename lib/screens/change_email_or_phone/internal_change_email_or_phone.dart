import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/controllers/auth/first_access.controller.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/string_support.dart';
import 'package:sme_app_aluno/utils/validators.util.dart';

class InternalChangeEmailOrPhone extends StatefulWidget {
  final int userId;

  InternalChangeEmailOrPhone({required this.userId});

  @override
  _InternalChangeEmailOrPhoneState createState() => _InternalChangeEmailOrPhoneState();
}

class _InternalChangeEmailOrPhoneState extends State<InternalChangeEmailOrPhone> {
  final UserService _userService = UserService();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  late FirstAccessController _firstAccessController;

  late ReactionDisposer disposer;

  bool _busy = false;
  String _email = "";
  String _phone = "";

  String _emailData = "";
  String _phoneData = "";

  @override
  void initState() {
    super.initState();
    _firstAccessController = FirstAccessController();
    loadInputs();
  }

  loadInputs() async {
    final User user = await _userService.find(widget.userId);
    String email = user.email;
    String phone = user.celular;
    var maskedPhone = phone != "" ? StringSupport.formatStringPhoneNumber(phone) : phone;

    setState(() => _email = email);
    setState(() => _phone = maskedPhone);
  }

  fetchChangeEmailOrPhone(String email, String phone, int userId) async {
    setState(() {
      _busy = true;
    });

    await _firstAccessController.changeEmailAndPhone(email, phone, userId, true).then((data) {
      _onSuccess();
    });

    setState(() {
      _busy = false;
    });
  }

  onError() {
    var snackbar = SnackBar(
        backgroundColor: Colors.red,
        content:
            _firstAccessController.data != null ? Text(_firstAccessController.data.erros[0]) : Text("Erro de serviço"));

    _scaffoldKey.currentState!.showSnackBar(snackbar);
  }

  _onSuccess() {
    if (_firstAccessController.dataEmailOrPhone.ok) {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.NO_HEADER,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Parabéns',
        desc: 'Dados alterados com sucesso!',
        btnOkText: "OK",
        btnOkOnPress: () {
          Navigator.of(context).pop(true);
        },
      )..show();
    } else {
      onError();
    }
  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text("Você não confirmou as suas alterações, deseja descartá-las?"),
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

    return WillPopScope(
      onWillPop: (_emailData.isNotEmpty || _phoneData.isNotEmpty) ? _onBackPress : null,
      child: Scaffold(
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
                          margin: EdgeInsets.only(bottom: screenHeight * 4, top: screenHeight * 3),
                          child: AutoSizeText(
                            "Alterar e-mail ou telefone",
                            maxFontSize: 18,
                            minFontSize: 16,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff757575),
                            ),
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
                                  border:
                                      Border(bottom: BorderSide(color: Color(0xffD06D12), width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  initialValue: _email,
                                  autovalidateMode: _email.isEmpty || _emailData != "",
                                  style: TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    return ValidatorsUtil.email(value);
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _emailData = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 1,
                              ),
                              AutoSizeText(
                                "Digite o endereço de e-mail",
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
                                  border:
                                      Border(bottom: BorderSide(color: Color(0xffD06D12), width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  initialValue: _phone,
                                  autovalidate: _phone.isNotEmpty || _phoneData.isNotEmpty,
                                  style: TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    labelText: 'Número de Telefone',
                                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.length != 15) {
                                        return 'Telefone inválido';
                                      }
                                    }

                                    return null;
                                  },
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    TelefoneInputFormatter(),
                                    LengthLimitingTextInputFormatter(15)
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      _phoneData = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 1,
                              ),
                              AutoSizeText(
                                "Digite o número do telefone com (DDD) e sem espaços",
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
                                      disabled: (_emailData.isNotEmpty &&
                                              _emailData != _email &&
                                              EmailValidator.validate(_emailData)) ||
                                          (_phoneData.isNotEmpty && _phoneData != _phone && _phoneData.length == 15),
                                      onPress: () {
                                        fetchChangeEmailOrPhone(_emailData.isEmpty ? _email : _emailData,
                                            _phoneData.isEmpty ? _phone : _phoneData, widget.userId);
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
      ),
    );
  }
}
