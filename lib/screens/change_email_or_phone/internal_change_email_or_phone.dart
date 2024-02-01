import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/auth/first_access.controller.dart';
import '../../models/user/user.dart';
import '../../services/user.service.dart';
import '../../ui/widgets/buttons/ea_deafult_button.widget.dart';
import '../../utils/string_support.dart';
import '../../utils/validators.util.dart';

class InternalChangeEmailOrPhone extends StatefulWidget {
  final int userId;

  const InternalChangeEmailOrPhone({super.key, required this.userId});

  @override
  InternalChangeEmailOrPhoneState createState() => InternalChangeEmailOrPhoneState();
}

class InternalChangeEmailOrPhoneState extends State<InternalChangeEmailOrPhone> {
  final UserService _userService = UserService();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirstAccessController _firstAccessController = FirstAccessController();

  //final ReactionDisposer disposer = ReactionDisposer);

  bool _busy = false;
  String _email = '';
  String _phone = '';

  String _emailData = '';
  String _phoneData = '';

  @override
  void initState() {
    super.initState();
    loadInputs();
  }

  void loadInputs() async {
    final User user = await _userService.find(widget.userId);
    final String email = user.email;
    final String phone = user.celular;
    final maskedPhone = phone != '' ? StringSupport.formatStringPhoneNumber(phone) : phone;

    setState(() => _email = email);
    setState(() => _phone = maskedPhone);
  }

  void fetchChangeEmailOrPhone(String email, String phone, int userId) async {
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

  void onError() {
    final snackbar = SnackBar(
      backgroundColor: Colors.red,
      content: _firstAccessController.data != null
          ? Text(_firstAccessController.data!.erros[0])
          : const Text('Erro de serviço'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _onSuccess() {
    if (_firstAccessController.dataEmailOrPhone.ok) {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.noHeader,
        animType: AnimType.bottomSlide,
        title: 'Parabéns',
        desc: 'Dados alterados com sucesso!',
        btnOkText: 'OK',
        btnOkOnPress: () {
          Navigator.of(context).pop(true);
        },
      ).show();
    } else {
      onError();
    }
  }

  void _onBackPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você não confirmou as suas alterações, deseja descartá-las?'),
          actions: [
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return PopScope(
      canPop: (_emailData.isNotEmpty || _phoneData.isNotEmpty),
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onBackPress();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Alterar Dados'),
          backgroundColor: const Color(0xffEEC25E),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 4, top: screenHeight * 3),
                      child: const AutoSizeText(
                        'Alterar e-mail ou telefone',
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff757575),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: screenHeight * 2),
                            decoration: BoxDecoration(
                              color: const Color(0xfff0f0f0),
                              border: Border(
                                bottom: BorderSide(color: const Color(0xffD06D12), width: screenHeight * 0.39),
                              ),
                            ),
                            child: TextFormField(
                              initialValue: _email,
                              autovalidateMode: AutovalidateMode.always,
                              style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                                errorStyle: TextStyle(fontWeight: FontWeight.w700),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return ValidatorsUtil.email(value!);
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
                          const AutoSizeText(
                            'Digite o endereço de e-mail',
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
                              color: const Color(0xfff0f0f0),
                              border: Border(
                                bottom: BorderSide(color: const Color(0xffD06D12), width: screenHeight * 0.39),
                              ),
                            ),
                            child: TextFormField(
                              initialValue: _phone,
                              autovalidateMode: AutovalidateMode.always,
                              style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
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
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                                LengthLimitingTextInputFormatter(15),
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
                          const AutoSizeText(
                            'Digite o número do telefone com (DDD) e sem espaços',
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
                              ? EADefaultButton(
                                  btnColor: const Color(0xffd06d12),
                                  iconColor: const Color(0xffffd037),
                                  icon: FontAwesomeIcons.chevronRight,
                                  enabled: (_emailData.isNotEmpty &&
                                          _emailData != _email &&
                                          EmailValidator.validate(_emailData)) ||
                                      (_phoneData.isNotEmpty && _phoneData != _phone && _phoneData.length == 15),
                                  text: 'ATUALIZAR',
                                  styleAutoSize: const TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                                  onPress: () {
                                    fetchChangeEmailOrPhone(
                                      _emailData.isEmpty ? _email : _emailData,
                                      _phoneData.isEmpty ? _phone : _phoneData,
                                      widget.userId,
                                    );
                                  },
                                )
                              : const GFLoader(
                                  type: GFLoaderType.square,
                                  loaderColorOne: Color(0xffDE9524),
                                  loaderColorTwo: Color(0xffC65D00),
                                  loaderColorThree: Color(0xffC65D00),
                                  size: GFSize.LARGE,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
