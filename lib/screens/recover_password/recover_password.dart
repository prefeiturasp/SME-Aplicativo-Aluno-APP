import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/formatter/cpf_input_formatter.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/auth/recover_password.controller.dart';
import 'package:sme_app_aluno/screens/recover_password/show_info.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class RecoverPassword extends StatefulWidget {
  final String input;

  RecoverPassword({this.input = ''});

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  bool loading = false;

  bool _cpfIsError = false;

  String _cpf = '';

  RecoverPasswordController _recoverPasswordController;

  @override
  void initState() {
    super.initState();
    _recoverPasswordController = RecoverPasswordController();
    setState(() {
      _cpf = widget.input != null ? widget.input : "";
    });
  }

  _onPressGetToken(String cpf, BuildContext context) async {
    setState(() {
      loading = true;
    });
    await _recoverPasswordController.sendToken(cpf);
    setState(() {
      loading = false;
    });
    if (_recoverPasswordController.data.email != null) {
      Nav.push(
          context,
          ShowInfo(
            email: _recoverPasswordController.data.email,
            cpf: cpf,
          ));
    } else {
      onError();
    }
  }

  onError() {
    var snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: _recoverPasswordController.data != null
            ? Text(_recoverPasswordController.data.erros[0])
            : Text("Erro de serviço"));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final _recoverPasswordController =
        Provider.of<RecoverPasswordController>(context);
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Resumo do Estudante"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF36621),
          ),
          onPressed: () => Nav.pop(context),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: screenHeight * 2.5, right: screenHeight * 2.5),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenHeight * 36,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: screenHeight * 6),
                        child:
                            Image.asset("assets/images/Logo_escola_aqui.png"),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: screenHeight * 6,
                            left: screenHeight * 6,
                            right: screenHeight * 6),
                        child: AutoSizeText(
                          "Ao continuar será acionada a opção de recuperação de senha e você receberá um e-mail com as orientações.",
                          textAlign: TextAlign.center,
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 5,
                          style: TextStyle(
                              color: Color(0xff757575),
                              fontWeight: FontWeight.bold),
                        ),
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
                                  initialValue: widget.input,
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
                                      _cpf = value;
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
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Nav.push(
                                        context,
                                        ShowInfo(
                                          hasToken: true,
                                        ));
                                  },
                                  child: AutoSizeText(
                                    "Já possuo um código",
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
                              loading
                                  ? GFLoader(
                                      type: GFLoaderType.square,
                                      loaderColorOne: Color(0xffDE9524),
                                      loaderColorTwo: Color(0xffC65D00),
                                      loaderColorThree: Color(0xffC65D00),
                                      size: GFSize.LARGE,
                                    )
                                  : EAButton(
                                      text: "CONTINUAR",
                                      icon: FontAwesomeIcons.chevronRight,
                                      iconColor: Color(0xffffd037),
                                      btnColor: Color(0xffd06d12),
                                      desabled: CPFValidator.isValid(_cpf),
                                      onPress: () {
                                        if (_formKey.currentState.validate()) {
                                          _onPressGetToken(_cpf, context);
                                        } else {
                                          return null;
                                        }
                                      },
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
