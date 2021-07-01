import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/autenticacao.controller.dart';
import 'package:sme_app_aluno/controllers/usuario.controller.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/screens/firstAccess/firstAccess.dart';
import 'package:sme_app_aluno/screens/recover_password/recover_password.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/stores/usuario.store.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/ui/views/atualizacao_cadastral.view.dart';
import 'package:sme_app_aluno/utils/navigator.dart';

class LoginView extends StatefulWidget {
  final String notice;

  LoginView({this.notice});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  final usuarioController = GetIt.I.get<UsuarioController>();
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  _handleSignIn(
    String cpf,
    String password,
  ) async {
    setState(() {
      _carregando = true;
    });

    UsuarioDataModel usuario =
        await autenticacaoController.authenticateUser(cpf, password);

    setState(() {
      _carregando = false;
    });

    if (!usuario.ok) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: usuario.erros != null
            ? Text(usuario.erros[0])
            : Text("Erro de serviço"),
      );

      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      if (usuarioStore.usuario.primeiroAcesso) {
        Nav.push(
            context,
            FirstAccess(
              id: usuarioStore.usuario.id,
              cpf: usuarioStore.usuario.cpf,
            ));
      } else if (usuarioStore.usuario.atualizarDadosCadastrais) {
        Nav.push(context, AtualizacaoCadastralView());
      } else {
        Nav.push(context, EstudanteListaView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

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
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenHeight * 36,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: screenHeight * 8, bottom: screenHeight * 6),
                        child:
                            Image.asset("assets/images/Logo_escola_aqui.png"),
                      ),
                      Form(
                        autovalidate: true,
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
                                        widget.notice,
                                        maxFontSize: 18,
                                        minFontSize: 16,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : SizedBox.shrink(),
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
                                          color: _cpfIsError
                                              ? Colors.red
                                              : Color(0xffD06D12),
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  initialValue: _cpf,
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
                                      _cpf = CPFValidator.strip(value);
                                    });

                                    setState(() {
                                      _cpfRaw = value;
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
                                margin: EdgeInsets.only(top: screenHeight * 5),
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
                                  obscureText: _showPassword,
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if (value.length <= 7) {
                                        return 'Sua senha deve conter no mínimo 8 caracteres';
                                      }
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: _showPassword
                                          ? Icon(FontAwesomeIcons.eye)
                                          : Icon(FontAwesomeIcons.eyeSlash),
                                      color: Color(0xff6e6e6e),
                                      iconSize: screenHeight * 3.0,
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                    labelText: 'Senha',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 1,
                              ),
                              AutoSizeText(
                                "Digite a sua senha. Caso você ainda não tenha uma senha pessoal informe a data de nascimento do aluno no padrão ddmmaaaa.",
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
                                    Nav.push(context,
                                        RecoverPassword(input: _cpfRaw));
                                  },
                                  child: AutoSizeText(
                                    "Esqueci minha senha",
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
                              _carregando
                                  ? GFLoader(
                                      type: GFLoaderType.square,
                                      loaderColorOne: Color(0xffDE9524),
                                      loaderColorTwo: Color(0xffC65D00),
                                      loaderColorThree: Color(0xffC65D00),
                                      size: GFSize.LARGE,
                                    )
                                  : EAButton(
                                      text: "ENTRAR",
                                      icon: FontAwesomeIcons.chevronRight,
                                      iconColor: Color(0xffffd037),
                                      btnColor: Color(0xffd06d12),
                                      disabled: CPFValidator.isValid(_cpf) &&
                                          _password.length >= 7,
                                      onPress: () {
                                        if (_formKey.currentState.validate()) {
                                          _handleSignIn(_cpf, _password);
                                        } else {
                                          setState(() {
                                            _cpfIsError = true;
                                            _passwordIsError = true;
                                          });
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
