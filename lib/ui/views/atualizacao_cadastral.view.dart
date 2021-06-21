import 'package:auto_size_text/auto_size_text.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/controllers/autenticacao.controller.dart';
import 'package:sme_app_aluno/controllers/auth/first_access.controller.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/widgets/ea_botao.widget.dart';
import 'package:sme_app_aluno/utils/assets.util.dart';
import 'package:sme_app_aluno/utils/auth.dart';
import 'package:sme_app_aluno/utils/colors.util.dart';
import 'package:sme_app_aluno/utils/validators.util.dart';

class AtualizacaoCadastralView extends StatefulWidget {
  AtualizacaoCadastralView();

  @override
  _AtualizacaoCadastralViewState createState() =>
      _AtualizacaoCadastralViewState();
}

class _AtualizacaoCadastralViewState extends State<AtualizacaoCadastralView> {
  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  final usuarioController = GetIt.I.get<UsuarioController>();
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _nomeMaeCtrl = new TextEditingController();
  MaskedTextController _dataNascimentoCtrl =
      new MaskedTextController(mask: '00/00/0000');
  MaskedTextController _cpfCtrl =
      new MaskedTextController(mask: '000.000.000-00');

  MaskedTextController _telefoneCtrl =
      new MaskedTextController(mask: '(00) 00000-0000');

  ReactionDisposer disposer;

  bool _busy = false;
  bool _declaracao = false;
  String _email = "";
  String _telefone = "";
  String _nomeMae = "";
  DateTime _dataNascimento;

  @override
  void initState() {
    super.initState();
    loadInputs();
  }

  loadInputs() async {
    setState(() {
      _dataNascimentoCtrl.text = usuarioStore.usuario.dataNascimento != null
          ? DateFormat("dd/MM/yyyy").format(usuarioStore.usuario.dataNascimento)
          : "";

      _dataNascimento = usuarioStore.usuario.dataNascimento;
      _cpfCtrl.text =
          usuarioStore.usuario.cpf.isNotEmpty ? usuarioStore.usuario.cpf : "";
      _telefoneCtrl.text = usuarioStore.usuario.celular.isNotEmpty
          ? usuarioStore.usuario.celular
          : "";
      _emailCtrl.text = usuarioStore.usuario.email;
      _nomeMaeCtrl.text = usuarioStore.usuario.nomeMae;
      _email = usuarioStore.usuario.email;

      _nomeMae = usuarioStore.usuario.nomeMae;
      _telefone = _telefoneCtrl.text;
    });
  }

  onClickFinalizarCadastro() async {
    setState(() {
      _busy = true;
    });

    var response = await usuarioController.atualizarDados(
        _nomeMae, _dataNascimento, _email, _telefone);

    setState(() {
      _busy = false;
    });

    if (response.ok) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListStudants(
              userId: usuarioStore.usuario.id,
            ),
          ));
    }

    if (!response.ok) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: response.erros != null
            ? Text(response.erros[0])
            : Text("Erro de serviço"),
      );

      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
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
                  await Auth.logout(context, usuarioStore.usuario.id, false);
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
                            child: AssetsUtil.logoEA,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                _onBackPress();
                              },
                              icon: Icon(
                                FontAwesomeIcons.signOutAlt,
                                color: ColorsUtil.laranja01,
                                size: screenHeight * 2,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 3),
                        child: AutoSizeText(
                          "Primeiro Acesso! Atualize os dados de cadastro",
                          maxFontSize: 18,
                          minFontSize: 16,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtil.cinza01,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Dados do responsável",
                            maxFontSize: 18,
                            minFontSize: 16,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsUtil.laranja02,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Observer(
                            builder: (context) => Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: ColorsUtil.campoDesabilitado,
                              ),
                              child: TextFormField(
                                initialValue: usuarioStore.usuario.nome,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: 'Nome completo do responsável',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 1,
                          ),
                          Observer(
                            builder: (context) => Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
                              decoration: BoxDecoration(
                                color: ColorsUtil.campoDesabilitado,
                              ),
                              child: TextFormField(
                                controller: _cpfCtrl,
                                enabled: false,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: 'CPF do responsável',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 5,
                          ),
                        ],
                      ),
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
                                  color: ColorsUtil.campoHabilitado,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorsUtil.campoBorda,
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  controller: _dataNascimentoCtrl,
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {
                                    setState(() {
                                      //_dataNascimento = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText:
                                        'Data de nascimento do responsável',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    return ValidatorsUtil.dataNascimento(value);
                                  },
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 2,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: screenHeight * 2),
                                decoration: BoxDecoration(
                                  color: ColorsUtil.campoHabilitado,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorsUtil.campoBorda,
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  controller: _nomeMaeCtrl,
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {
                                    setState(() {
                                      _nomeMae = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Nome da mãe do responsável',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    return ValidatorsUtil.nomeMae(value);
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 2,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: screenHeight * 2),
                                decoration: BoxDecoration(
                                  color: ColorsUtil.campoHabilitado,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorsUtil.campoBorda,
                                          width: screenHeight * 0.39)),
                                ),
                                child: TextFormField(
                                  controller: _emailCtrl,
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'E-mail do responsável',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (!EmailValidator.validate(_email)) {
                                      return 'E-mail inválido';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 2,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: screenHeight * 2),
                                decoration: BoxDecoration(
                                  color: ColorsUtil.campoHabilitado,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: ColorsUtil.campoBorda,
                                        width: screenHeight * 0.39),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _telefoneCtrl,
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {
                                    setState(() {
                                      _telefone = value;
                                    });
                                  },
                                  validator: (value) {
                                    return ValidatorsUtil.telefone(value);
                                  },
                                  decoration: InputDecoration(
                                    labelText:
                                        'Telefone celular do responsável',
                                    labelStyle:
                                        TextStyle(color: Color(0xff8e8e8e)),
                                    errorStyle:
                                        TextStyle(fontWeight: FontWeight.w700),
                                    // hintText: "Data de nascimento do aluno",
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 1,
                              ),
                              InfoBox(
                                icon: FontAwesomeIcons.exclamationTriangle,
                                content: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 280,
                                        child: AutoSizeText(
                                          "Declaro que as informações acima são verdadeiras",
                                          maxFontSize: 18,
                                          minFontSize: 16,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorsUtil.cinza01),
                                        ),
                                      ),
                                      Checkbox(
                                        value: _declaracao,
                                        activeColor: ColorsUtil.laranja01,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _formKey.currentState.validate();
                                            _declaracao = newValue;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 5,
                              ),
                              !_busy
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        EABotaoWidget(
                                          text: "FINALIZAR CADASTRO",
                                          icon: FontAwesomeIcons.chevronRight,
                                          iconColor: Color(0xffffd037),
                                          btnColor: Color(0xffd06d12),
                                          enabled: habilitaBotaoCadastro(),
                                          onPress: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              onClickFinalizarCadastro();
                                            }
                                          },
                                        ),
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
      ),
    );
  }

  bool habilitaBotaoCadastro() {
    if (_nomeMae == null) {
      return false;
    }
    if (_telefone.isEmpty || _nomeMae.isEmpty) {
      return false;
    }
    if (!_declaracao) {
      return false;
    }
    return true;
  }
}
