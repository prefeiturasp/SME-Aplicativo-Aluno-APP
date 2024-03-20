import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../controllers/index.dart';
import '../../screens/widgets/info_box/info_box.dart';
import '../../stores/index.dart';
import '../../utils/colors.util.dart';
import '../../utils/validators.util.dart';
import '../index.dart';

class MeusDadosEditarView extends StatefulWidget {
  const MeusDadosEditarView({super.key});

  @override
  MeusDadosEditarViewState createState() => MeusDadosEditarViewState();
}

class MeusDadosEditarViewState extends State<MeusDadosEditarView> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final usuarioController = GetIt.I.get<UsuarioController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nomeMaeCtrl = TextEditingController();
  final MaskedTextController _dataNascimentoCtrl = MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _cpfCtrl = MaskedTextController(mask: '000.000.000-00');

  final MaskedTextController _telefoneCtrl = MaskedTextController(mask: '(00) 00000-0000');

  final _formKey = GlobalKey<FormState>();

  bool _busy = false;
  bool _declaracao = false;
  String _telefone = '';
  String _nomeMae = '';
  DateTime _dataNascimento = DateTime.now();

  @override
  void initState() {
    super.initState();

    _dataNascimentoCtrl.text = usuarioStore.usuario?.dataNascimento != null
        ? DateFormat('dd/MM/yyyy').format(usuarioStore.usuario!.dataNascimento)
        : '';

    _cpfCtrl.text = usuarioStore.usuario?.cpf != null ? usuarioStore.usuario!.cpf : '';
    _telefoneCtrl.text = usuarioStore.usuario?.celular != null ? usuarioStore.usuario!.celular : '';
    _emailCtrl.text = usuarioStore.usuario?.email != null ? usuarioStore.usuario!.email : '';
    _nomeMaeCtrl.text = usuarioStore.usuario?.nomeMae != null ? usuarioStore.usuario!.nomeMae : '';

    _dataNascimento = usuarioStore.usuario?.dataNascimento ?? usuarioStore.usuario!.dataNascimento;
    _telefone = _telefoneCtrl.text;
    _nomeMae = _nomeMaeCtrl.text;
  }

  Future<bool> onClickFinalizarCadastro() async {
    setState(() {
      _busy = true;
    });

    final data = _dataNascimentoCtrl.text.split('/');
    _dataNascimento = DateTime.parse('${data[2]}${data[1]}${data[0]}');

    final response = await usuarioController.atualizarDados(
      _nomeMaeCtrl.text.trim(),
      _dataNascimento,
      _emailCtrl.text.trim(),
      _telefoneCtrl.text,
    );

    setState(() {
      _busy = false;
    });

    if (!response.ok) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: response.erros != null ? Text(response.erros![0]) : const Text('Erro de serviço'),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return response.ok;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text('Editar dados do responsável'),
        backgroundColor: const Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const AutoSizeText(
                'Dados do responsável',
                maxFontSize: 18,
                minFontSize: 16,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorsUtil.laranja02,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
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
                          initialValue: usuarioStore.usuario!.nome,
                          style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            labelText: 'Nome completo do responsável',
                            labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                            errorStyle: TextStyle(fontWeight: FontWeight.w700),
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
                          style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            labelText: 'CPF do responsável',
                            labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                            errorStyle: TextStyle(fontWeight: FontWeight.w700),
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
                              bottom: BorderSide(color: ColorsUtil.campoBorda, width: screenHeight * 0.39),
                            ),
                          ),
                          child: TextFormField(
                            controller: _dataNascimentoCtrl,
                            style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                            onChanged: (value) {
                              setState(
                                () {
                                  if (value.isNotEmpty) {
                                    final data = value.split('/');
                                    _dataNascimento = DateTime.parse('${data[2]}${data[1]}${data[0]}');
                                  }
                                },
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Data de nascimento do responsável',
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle: TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              return ValidatorsUtil.dataNascimento(value!);
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
                              bottom: BorderSide(color: ColorsUtil.campoBorda, width: screenHeight * 0.39),
                            ),
                          ),
                          child: TextFormField(
                            controller: _nomeMaeCtrl,
                            style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                            onChanged: (value) {
                              setState(() {
                                _nomeMae = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Filiação do responsável legal',
                              hintText: 'Preferencialmente nome da mãe',
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle: TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              return ValidatorsUtil.nome(value!, 'Nome do responsável legal');
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
                              bottom: BorderSide(color: ColorsUtil.campoBorda, width: screenHeight * 0.39),
                            ),
                          ),
                          child: TextFormField(
                            controller: _emailCtrl,
                            style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              labelText: 'E-mail do responsável',
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle: TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              return ValidatorsUtil.email(value!);
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
                              bottom: BorderSide(color: ColorsUtil.campoBorda, width: screenHeight * 0.39),
                            ),
                          ),
                          child: TextFormField(
                            controller: _telefoneCtrl,
                            style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w600),
                            onChanged: (value) {
                              setState(() {
                                _telefone = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Telefone celular do responsável',
                              labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                              errorStyle: TextStyle(fontWeight: FontWeight.w700),
                              // hintText: "Data de nascimento do aluno",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              return ValidatorsUtil.telefone(value!);
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 1,
                        ),
                        InfoBox(
                          icon: FontAwesomeIcons.triangleExclamation,
                          content: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: const AutoSizeText(
                                    'Declaro que as informações acima são verdadeiras',
                                    maxFontSize: 18,
                                    minFontSize: 16,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: ColorsUtil.cinza01),
                                  ),
                                ),
                                Checkbox(
                                  value: _declaracao,
                                  activeColor: ColorsUtil.laranja01,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _formKey.currentState!.validate();
                                      _declaracao = newValue!;
                                    });
                                  },
                                ),
                              ],
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
                                  EADefaultButton(
                                    text: 'SALVAR CADASTRO',
                                    iconColor: const Color(0xffffd037),
                                    btnColor: const Color(0xffd06d12),
                                    enabled: habilitaBotaoCadastro(),
                                    onPress: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final retorno = await onClickFinalizarCadastro();
                                        if (retorno) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ],
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
    );
  }

  bool habilitaBotaoCadastro() {
    if (_nomeMae.isEmpty) {
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
