import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/screens/widgets/info_box/info_box.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/utils/colors.util.dart';
import 'package:sme_app_aluno/utils/validators.util.dart';

class MeusDadosEditarView extends StatefulWidget {
  @override
  _MeusDadosEditarViewState createState() => _MeusDadosEditarViewState();
}

class _MeusDadosEditarViewState extends State<MeusDadosEditarView> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final usuarioController = GetIt.I.get<UsuarioController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _nomeMaeCtrl = new TextEditingController();
  MaskedTextController _dataNascimentoCtrl =
      new MaskedTextController(mask: '00/00/0000');
  MaskedTextController _cpfCtrl =
      new MaskedTextController(mask: '000.000.000-00');

  MaskedTextController _telefoneCtrl =
      new MaskedTextController(mask: '(00) 00000-0000');

  final _formKey = GlobalKey<FormState>();

  bool _busy = false;
  bool _declaracao = false;
  String _email = "";
  String _telefone = "";
  String _nomeMae = "";
  DateTime _dataNascimento;

  @override
  void initState() {
    super.initState();

    _dataNascimentoCtrl.text = usuarioStore.usuario.dataNascimento != null
        ? DateFormat("dd/MM/yyyy").format(usuarioStore.usuario.dataNascimento)
        : "";

    _cpfCtrl.text =
        usuarioStore.usuario.cpf.isNotEmpty ? usuarioStore.usuario.cpf : "";
    _telefoneCtrl.text = usuarioStore.usuario.celular != null
        ? usuarioStore.usuario.celular
        : "";
    _emailCtrl.text = usuarioStore.usuario.email;
    _nomeMaeCtrl.text = usuarioStore.usuario.nomeMae;

    _dataNascimento = usuarioStore.usuario.dataNascimento;
    _telefone = _telefoneCtrl.text;
    _email = _emailCtrl.text;
    _nomeMae = _nomeMaeCtrl.text;
  }

  Future<bool> onClickFinalizarCadastro() async {
    setState(() {
      _busy = true;
    });

    var data = _dataNascimentoCtrl.text.split("/");
    _dataNascimento = DateTime.parse("${data[2]}${data[1]}${data[0]}");

    var response = await usuarioController.atualizarDados(
        _nomeMaeCtrl.text.trim(),
        _dataNascimento,
        _emailCtrl.text.trim(),
        _telefoneCtrl.text);

    setState(() {
      _busy = false;
    });

    if (!response.ok) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: response.erros != null
            ? Text(response.erros[0])
            : Text("Erro de serviço"),
      );

      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    return response.ok;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text("Editar dados do responsável"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
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
              Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle:
                                  TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            enabled: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 1,
                        ),
                        Container(
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
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle:
                                  TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                              padding: EdgeInsets.only(left: screenHeight * 2),
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
                                  setState(
                                    () {
                                      if (value.isNotEmpty) {
                                        var data = value.split("/");
                                        _dataNascimento = DateTime.parse(
                                            "${data[2]}${data[1]}${data[0]}");
                                      }
                                    },
                                  );
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
                              padding: EdgeInsets.only(left: screenHeight * 2),
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
                                  labelText: 'Filiação do responsável legal',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  return ValidatorsUtil.nome(
                                      value, "Nome da mãe");
                                },
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 2,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
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
                                  return ValidatorsUtil.email(value);
                                },
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 2,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: screenHeight * 2),
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
                                decoration: InputDecoration(
                                  labelText: 'Telefone celular do responsável',
                                  labelStyle:
                                      TextStyle(color: Color(0xff8e8e8e)),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  // hintText: "Data de nascimento do aluno",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  return ValidatorsUtil.telefone(value);
                                },
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
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
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
                                      EADefaultButton(
                                        text: "SALVAR CADASTRO",
                                        iconColor: Color(0xffffd037),
                                        btnColor: Color(0xffd06d12),
                                        enabled: habilitaBotaoCadastro(),
                                        onPress: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            var retorno =
                                                await onClickFinalizarCadastro();
                                            if (retorno) {
                                              Navigator.pop(context);
                                            }
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
            ],
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
