import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/auth/recover_password.controller.dart';
import '../../ui/widgets/buttons/ea_deafult_button.widget.dart';
import '../../utils/navigator.dart';
import 'show_info.dart';

class RecoverPassword extends StatefulWidget {
  final String input;

  const RecoverPassword({super.key, this.input = ''});

  @override
  RecoverPasswordState createState() => RecoverPasswordState();
}

class RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  final bool _cpfIsError = false;

  String _cpf = '';

  final RecoverPasswordController _recoverPasswordController = RecoverPasswordController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _cpf = widget.input;
    });
  }

  Future<void> _onPressGetToken(String cpf, BuildContext context) async {
    setState(() {
      loading = true;
    });
    await _recoverPasswordController.sendToken(cpf);
    setState(() {
      loading = false;
    });
    if (_recoverPasswordController.data!.email.isNotEmpty && context.mounted) {
      Nav.push(
        context,
        ShowInfo(
          email: _recoverPasswordController.data!.email,
          cpf: cpf,
        ),
      );
    } else {
      onError();
    }
  }

  void onError() {
    final snackbar = SnackBar(
      backgroundColor: Colors.red,
      content: _recoverPasswordController.data != null
          ? Text(_recoverPasswordController.data!.erros[0])
          : const Text('Erro de serviço'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Resumo do Estudante'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF36621),
          ),
          onPressed: () => Nav.pop(context),
        ),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) {
            Nav.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: screenHeight * 2.5, right: screenHeight * 2.5),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: screenHeight * 36,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: screenHeight * 6),
                      child: Image.asset('assets/images/Logo_escola_aqui.png'),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(bottom: screenHeight * 6, left: screenHeight * 6, right: screenHeight * 6),
                      child: const AutoSizeText(
                        'Ao continuar será acionada a opção de recuperação de senha e você receberá um e-mail com as orientações.',
                        textAlign: TextAlign.center,
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 5,
                        style: TextStyle(color: Color(0xff757575), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
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
                                bottom: BorderSide(
                                  color: _cpfIsError ? Colors.red : const Color(0xffD06D12),
                                  width: screenHeight * 0.39,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              initialValue: widget.input,
                              style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                labelText: 'Usuário',
                                labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                                errorStyle: TextStyle(fontWeight: FontWeight.w700),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _cpf = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  if (!CPFValidator.isValid(_cpf)) {
                                    return 'CPF inválido';
                                  }
                                }

                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 1,
                          ),
                          const AutoSizeText(
                            'Digite o CPF do responsável',
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
                                    email: _recoverPasswordController.data!.email,
                                    cpf: _cpf,
                                  ),
                                );
                              },
                              child: const AutoSizeText(
                                'Já possuo um código',
                                maxFontSize: 14,
                                minFontSize: 12,
                                maxLines: 3,
                                style: TextStyle(color: Color(0xff757575), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 4,
                          ),
                          loading
                              ? const GFLoader(
                                  type: GFLoaderType.square,
                                  loaderColorOne: Color(0xffDE9524),
                                  loaderColorTwo: Color(0xffC65D00),
                                  loaderColorThree: Color(0xffC65D00),
                                  size: GFSize.LARGE,
                                )
                              : EADefaultButton(
                                  text: 'CONTINUAR',
                                  icon: FontAwesomeIcons.chevronRight,
                                  iconColor: const Color(0xffffd037),
                                  btnColor: const Color(0xffd06d12),
                                  enabled: CPFValidator.isValid(_cpf),
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      _onPressGetToken(_cpf, context);
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: screenHeight * 6,
                  margin: const EdgeInsets.only(top: 70),
                  child: Image.asset('assets/images/logo_sme.png', fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
