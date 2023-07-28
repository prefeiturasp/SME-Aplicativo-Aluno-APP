import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/auth/recover_password.controller.dart';
import '../../ui/views/login.view.dart';
import '../../ui/widgets/buttons/ea_deafult_button.widget.dart';
import '../../utils/navigator.dart';
import '../../utils/string_support.dart';
import '../redefine_password/redefine_password.dart';

class ShowInfo extends StatefulWidget {
  final String cpf;
  final String email;
  final bool hasToken;

  const ShowInfo({super.key, required this.email, this.hasToken = false, required this.cpf});

  @override
  ShowInfoState createState() => ShowInfoState();
}

class ShowInfoState extends State<ShowInfo> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final RecoverPasswordController _recoverPasswordController = RecoverPasswordController();

  String _token = '';

  @override
  void initState() {
    super.initState();
  }

  _onPressValidateToken(String token, BuildContext context) async {
    await _recoverPasswordController.validateToken(token);
    if (_recoverPasswordController.data!.ok && context.mounted) {
      Nav.push(
        context,
        RedefinePassword(
          cpf: widget.cpf,
          token: token,
        ),
      );
    } else {
      onError();
    }
  }

  onError() {
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF36621),
          ),
          onPressed: () => Nav.push(
            context,
            const LoginView(
              notice: '',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    padding: EdgeInsets.only(bottom: screenHeight * 6, left: screenHeight * 6, right: screenHeight * 6),
                    child: Column(
                      children: <Widget>[
                        widget.hasToken
                            ? const AutoSizeText(
                                'As orientações já foram enviadas \n para o email cadastrado.',
                                textAlign: TextAlign.center,
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 5,
                                style: TextStyle(color: Color(0xff757575), fontWeight: FontWeight.bold),
                              )
                            : const AutoSizeText(
                                'As orientações para recuperação de \n senha foram enviadas para',
                                textAlign: TextAlign.center,
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 5,
                                style: TextStyle(color: Color(0xff757575), fontWeight: FontWeight.bold),
                              ),
                        widget.hasToken
                            ? Container()
                            : SizedBox(
                                height: screenHeight * 3,
                              ),
                        widget.hasToken
                            ? Container()
                            : AutoSizeText(
                                StringSupport.replaceEmailSecurity(widget.email, 3),
                                textAlign: TextAlign.center,
                                maxFontSize: 16,
                                minFontSize: 14,
                                maxLines: 5,
                                style: const TextStyle(color: Color(0xffD16C12), fontWeight: FontWeight.bold),
                              ),
                        SizedBox(
                          height: screenHeight * 3,
                        ),
                        AutoSizeText(
                          widget.hasToken ? 'Verifique sua caixa de entrada!' : 'verifique sua caixa de entrada!',
                          textAlign: TextAlign.center,
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 5,
                          style: const TextStyle(color: Color(0xff757575), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenHeight * 25,
                          padding: EdgeInsets.only(left: screenHeight * 2),
                          decoration: BoxDecoration(
                            color: const Color(0xfff0f0f0),
                            border: Border(
                              bottom: BorderSide(color: const Color(0xffD06D12), width: screenHeight * 0.39),
                            ),
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                            decoration: const InputDecoration(
                              labelText: 'Código',
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle: TextStyle(fontWeight: FontWeight.w700),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _token = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 6,
                        ),
                        Observer(
                          builder: (context) {
                            if (_recoverPasswordController.loading) {
                              return const GFLoader(
                                type: GFLoaderType.square,
                                loaderColorOne: Color(0xffDE9524),
                                loaderColorTwo: Color(0xffC65D00),
                                loaderColorThree: Color(0xffC65D00),
                                size: GFSize.LARGE,
                              );
                            } else {
                              return EADefaultButton(
                                text: 'CONTINUAR',
                                icon: FontAwesomeIcons.chevronRight,
                                iconColor: const Color(0xffffd037),
                                btnColor: const Color(0xffd06d12),
                                enabled: _token.length == 8,
                                onPress: () {
                                  _onPressValidateToken(_token, context);
                                },
                              );
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
    );
  }
}
