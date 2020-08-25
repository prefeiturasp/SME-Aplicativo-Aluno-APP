import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/controllers/auth/first_access.controller.dart';
import 'package:sme_app_aluno/screens/change_email_or_phone/internal_change_email_or_phone.dart';
import 'package:sme_app_aluno/screens/change_password/change_password.dart';
import 'package:sme_app_aluno/screens/widgets/buttons/eabutton.dart';
import 'package:sme_app_aluno/screens/widgets/view_data/view.data.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class Settings extends StatefulWidget {
  final String currentCPF;
  final String email;
  final String phone;
  final int userId;

  Settings({
    @required this.currentCPF,
    @required this.email,
    @required this.phone,
    @required this.userId,
  });

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FirstAccessController _firstAccessController;

  @override
  void initState() {
    super.initState();
    _firstAccessController = FirstAccessController();
    _firstAccessController.loadUserForStorage(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text("Configurações"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              margin: EdgeInsets.only(top: screenHeight * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    "Dados cadastrais",
                    maxFontSize: 18,
                    minFontSize: 16,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: screenHeight * 4,
                  ),
                  ViewData(
                    label: "Usuário",
                    text: widget.currentCPF ?? "",
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Observer(builder: (context) {
                      if (_firstAccessController.currentPhone == null) {
                        return Container();
                      } else {
                        return Column(
                          children: <Widget>[
                            ViewData(
                              label: "Email",
                              text: _firstAccessController.currentEmail,
                            ),
                            ViewData(
                              label: "Telefone",
                              text: StringSupport.formatStringPhoneNumber(
                                  _firstAccessController.currentPhone),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: screenHeight * 2.5,
                  ),
                  EAButton(
                    text: "ALTERAR DADOS",
                    icon: FontAwesomeIcons.chevronRight,
                    iconColor: Color(0xffffd037),
                    btnColor: Color(0xffd06d12),
                    desabled: true,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InternalChangeEmailOrPhone(
                                    userId: widget.userId,
                                  ))).whenComplete(() => _firstAccessController
                          .loadUserForStorage(widget.userId));
                    },
                  )
                ],
              )),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          Divider(
            height: 0.5,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              margin: EdgeInsets.only(top: screenHeight * 3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ViewData(
                      label: "Senha",
                      text: "******",
                    ),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                    EAButton(
                      text: "ALTERAR SENHA",
                      icon: FontAwesomeIcons.chevronRight,
                      iconColor: Color(0xffffd037),
                      btnColor: Color(0xffd06d12),
                      desabled: true,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword(
                                    cpf: widget.currentCPF,
                                    id: widget.userId)));
                      },
                    )
                  ]))
        ],
      )),
    );
  }
}
