import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../screens/change_password/change_password.dart';
import '../../screens/widgets/view_data/view.data.dart';
import '../../stores/index.dart';
import '../../utils/colors.util.dart';
import '../index.dart';

class MeusDadosView extends StatefulWidget {
  const MeusDadosView({super.key});

  @override
  _MeusDadosViewState createState() => _MeusDadosViewState();
}

class _MeusDadosViewState extends State<MeusDadosView> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nomeMaeCtrl = TextEditingController();
  final MaskedTextController _dataNascimentoCtrl = MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _cpfCtrl = MaskedTextController(mask: '000.000.000-00');

  final MaskedTextController _telefoneCtrl = MaskedTextController(mask: '(00) 00000-0000');

  @override
  void initState() {
    loadInputs();
    super.initState();
  }

  void loadInputs() {
    _dataNascimentoCtrl.text = usuarioStore.usuario?.dataNascimento != null
        ? DateFormat('dd/MM/yyyy').format(usuarioStore.usuario!.dataNascimento)
        : '';

    _cpfCtrl.text = usuarioStore.usuario?.cpf ?? '';
    _telefoneCtrl.text = usuarioStore.usuario?.celular ?? '';
    _emailCtrl.text = usuarioStore.usuario?.email ?? '';
    _nomeMaeCtrl.text = usuarioStore.usuario?.nomeMae ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text('Dados do responsável'),
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
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                width: screenWidth - 10,
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  initialValue: usuarioStore.usuario!.nome,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
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
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
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
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _dataNascimentoCtrl,
                  enabled: false,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Data de nascimento do responsável',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.datetime,
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
                  controller: _nomeMaeCtrl,
                  enabled: false,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Filiação do responsável legal',
                    hintText: 'Preferencialmente nome da mãe',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
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
                  controller: TextEditingController(text: usuarioStore.usuario!.email),
                  enabled: false,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'E-mail do responsável',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
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
                  controller: _telefoneCtrl,
                  enabled: false,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Telefone celular do responsável',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 1.5,
              ),
              Observer(
                builder: (_) => Center(
                  child: Text(
                    usuarioStore.usuario!.ultimaAtualizacao != null
                        ? "Dados atualizados em: ${DateFormat("dd/MM/yyyy").format(usuarioStore.usuario!.ultimaAtualizacao!)} às ${DateFormat("HH:mm").format(usuarioStore.usuario!.ultimaAtualizacao!)}"
                        : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xff333333)),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 3,
              ),
              EADefaultButton(
                text: 'EDITAR DADOS',
                icon: FontAwesomeIcons.edit,
                iconColor: const Color(0xffffd037),
                btnColor: const Color(0xffd06d12),
                enabled: true,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MeusDadosEditarView(),
                    ),
                  ).then(
                    (value) => setState(() {
                      loadInputs();
                    }),
                  );
                },
              ),
              const Divider(
                height: 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: screenHeight * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const ViewData(
                      label: 'Senha',
                      text: '******',
                    ),
                    SizedBox(
                      height: screenHeight * 1,
                    ),
                    EADefaultButton(
                      text: 'ALTERAR SENHA',
                      icon: FontAwesomeIcons.chevronRight,
                      iconColor: const Color(0xffffd037),
                      btnColor: const Color(0xffd06d12),
                      enabled: true,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(
                              cpf: usuarioStore.usuario!.cpf,
                              id: usuarioStore.usuario!.id,
                            ),
                          ),
                        );
                      },
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
}
