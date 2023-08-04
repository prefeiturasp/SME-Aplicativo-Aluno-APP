import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/autenticacao.controller.dart';
import '../../controllers/usuario.controller.dart';
import '../../models/index.dart';
import '../../screens/firstAccess/first_access.dart';
import '../../screens/recover_password/recover_password.dart';
import '../../stores/usuario.store.dart';
import '../../utils/navigator.dart';
import '../index.dart';

class LoginView extends StatefulWidget {
  final String? notice;

  const LoginView({super.key, required this.notice});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  final usuarioController = GetIt.I.get<UsuarioController>();
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  bool _showPassword = true;
  bool _cpfIsError = false;
  bool _passwordIsError = false;
  bool _carregando = false;

  String _cpf = '';
  String _cpfRaw = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleSignIn(
    String cpf,
    String password,
  ) async {
    setState(() {
      _carregando = true;
    });

    final UsuarioDataModel usuario = await autenticacaoController.authenticateUser(cpf, password);

    setState(() {
      _carregando = false;
    });

    if (!usuario.ok) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: usuario.erros.isNotEmpty ? Text(usuario.erros[0]) : const Text('Erro de serviço'),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (usuarioStore.usuario!.primeiroAcesso && context.mounted) {
        Nav.push(
          context,
          FirstAccess(
            id: usuarioStore.usuario!.id,
            cpf: usuarioStore.usuario!.cpf,
          ),
        );
      } else if (usuarioStore.usuario!.atualizarDadosCadastrais) {
        Nav.push(context, const AtualizacaoCadastralView());
      } else {
        Nav.push(context, const EstudanteListaView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: screenHeight * 36,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: screenHeight * 8, bottom: screenHeight * 6),
                      child: Image.asset('assets/images/Logo_escola_aqui.png'),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
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
                                    widget.notice!,
                                    maxFontSize: 18,
                                    minFontSize: 16,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: screenHeight * 4,
                          ),
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
                              initialValue: _cpf,
                              style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                labelText: 'Usuário',
                                labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                                errorStyle: TextStyle(fontWeight: FontWeight.w700),
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
                            margin: EdgeInsets.only(top: screenHeight * 5),
                            padding: EdgeInsets.only(left: screenHeight * 2),
                            decoration: BoxDecoration(
                              color: const Color(0xfff0f0f0),
                              border: Border(
                                bottom: BorderSide(
                                  color: _passwordIsError ? Colors.red : const Color(0xffD06D12),
                                  width: screenHeight * 0.39,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                              obscureText: _showPassword,
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  if (value.length <= 7) {
                                    return 'Sua senha deve conter no mínimo 8 caracteres';
                                  }
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: _showPassword
                                      ? const Icon(FontAwesomeIcons.eye)
                                      : const Icon(FontAwesomeIcons.eyeSlash),
                                  color: const Color(0xff6e6e6e),
                                  iconSize: screenHeight * 3.0,
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                                labelText: 'Senha',
                                labelStyle: const TextStyle(color: Color(0xff8e8e8e)),
                                errorStyle: const TextStyle(fontWeight: FontWeight.w700),
                                // hintText: "Data de nascimento do aluno",
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 1,
                          ),
                          const AutoSizeText(
                            'Digite a sua senha. Caso você ainda não tenha uma senha pessoal informe a data de nascimento do aluno no padrão ddmmaaaa.',
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
                                Nav.push(context, RecoverPassword(input: _cpfRaw));
                              },
                              child: const AutoSizeText(
                                'Esqueci minha senha',
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
                          _carregando
                              ? const GFLoader(
                                  type: GFLoaderType.square,
                                  loaderColorOne: Color(0xffDE9524),
                                  loaderColorTwo: Color(0xffC65D00),
                                  loaderColorThree: Color(0xffC65D00),
                                  size: GFSize.LARGE,
                                )
                              : EADefaultButton(
                                  text: 'ENTRAR',
                                  icon: FontAwesomeIcons.chevronRight,
                                  iconColor: const Color(0xffffd037),
                                  btnColor: const Color(0xffd06d12),
                                  enabled: CPFValidator.isValid(_cpf) && _password.length >= 7,
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      handleSignIn(_cpf, _password);
                                    } else {
                                      setState(() {
                                        _cpfIsError = true;
                                        _passwordIsError = true;
                                      });
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
