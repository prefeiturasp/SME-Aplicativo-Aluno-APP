import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/controllers/auth/first_access.controller.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eaback_button.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class ChangeEmailOrPhone extends StatefulWidget {
  final String cpf;
  final String password;
  final int userId;

  ChangeEmailOrPhone({
    @required this.cpf,
    @required this.password,
    @required this.userId,
  });

  @override
  _ChangeEmailOrPhoneState createState() => _ChangeEmailOrPhoneState();
}

class _ChangeEmailOrPhoneState extends State<ChangeEmailOrPhone> {
  final UserService _userService = UserService();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailController;
  TextEditingController _phoneController;
  FirstAccessController _firstAccessController;

  ReactionDisposer disposer;

  bool _busy = false;
  String _email;
  String _phone;

  @override
  void initState() {
    super.initState();
    _firstAccessController = FirstAccessController();
    loadInputs();
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

  loadInputs() async {
    final User user = await _userService.find(widget.userId);
    String email = user.email;
    String phone = user.celular;

    var maskedPhone =
        phone.isNotEmpty ? StringSupport.formatStringPhoneNumber(phone) : phone;

    setState(() {
      _email = email;
    });
    setState(() {
      _phone = maskedPhone;
    });
  }

  fetchChangeEmailOrPhone(
      String email, String phone, bool changePassword) async {
    setState(() {
      _busy = true;
    });
    await _firstAccessController.changeEmailAndPhone(
        email, phone, widget.userId, changePassword);
    setState(() {
      _busy = false;
    });
  }

  onError() {
    var snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: _firstAccessController.data != null
            ? Text(_firstAccessController.data.erros[0])
            : Text("Erro de serviço"));

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _navigateToListStudents() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListStudants(
            userId: widget.userId,
            password: widget.password,
          ),
        ));
  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Deseja sair do aplicativo?'),
            content: Text(
              "Ao confirmar você será desconectado do aplicado. Para voltar para esta etapa você deverá realizar o login novamente. Deseja realmente sair do aplicativo?",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('NÃO'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('SIM'),
                onPressed: () async {
                  await Auth.logout(context, widget.userId);
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
    // _loadEmailAndCelular();

    var one = widget.cpf.characters.getRange(0, 3);
    var two = widget.cpf.characters.getRange(3, 6);
    var three = widget.cpf.characters.getRange(6, 9);
    var four = widget.cpf.characters.getRange(9, 11);
    String userCpf = "$one.$two.$three-$four";

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _onBackPress,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(screenHeight * 2.5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: screenHeight * 36,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  top: screenHeight * 8,
                                  bottom: screenHeight * 2),
                              child: Image.asset(
                                  "assets/images/Logo_escola_aqui.png"),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  _onBackPress();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: Color(0xFFE1771D),
                                  size: screenHeight * 2,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: screenHeight * 3),
                            child: AutoSizeText(
                              "Informe um e-mail ou número de celular para ser utilizado para a recuperação da senha para o CPF: ${userCpf}",
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
                                  padding:
                                      EdgeInsets.only(left: screenHeight * 2),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff0f0f0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffD06D12),
                                            width: screenHeight * 0.39)),
                                  ),
                                  child: TextFormField(
                                    initialValue: _email,
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
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'E-mail',
                                      labelStyle:
                                          TextStyle(color: Color(0xff8e8e8e)),
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.w700),
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
                                  padding:
                                      EdgeInsets.only(left: screenHeight * 2),
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
                                    initialValue: _phone,
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
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.w700),
                                      // hintText: "Data de nascimento do aluno",
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (_email != null) {
                                        if (_email.isEmpty &&
                                            value.length != 15) {
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
                                SizedBox(
                                  height: screenHeight * 5,
                                ),
                                !_busy
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          EAButton(
                                            text: "CADASTRAR",
                                            icon: FontAwesomeIcons.chevronRight,
                                            iconColor: Color(0xffffd037),
                                            btnColor: Color(0xffd06d12),
                                            desabled: EmailValidator.validate(
                                                    _email) ||
                                                _phone.length == 15,
                                            onPress: () {
                                              fetchChangeEmailOrPhone(
                                                  _email, _phone, false);
                                            },
                                          ),
                                          SizedBox(height: screenHeight * 3),
                                          EABackButton(
                                              text: "CADASTRAR MAIS TARDE",
                                              btnColor: Color(0xffd06d12),
                                              icon:
                                                  FontAwesomeIcons.chevronLeft,
                                              iconColor: Color(0xffffd037),
                                              onPress: () {
                                                _onBackPress();
                                              },
                                              desabled: true),
                                        ],
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
        ));
  }
}
