import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/authenticate.controller.dart';
import 'package:sme_app_aluno/screens/login/login.dart';
import 'package:sme_app_aluno/screens/students/list_studants.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authenticateController =
        Provider.of<AuthenticateController>(context, listen: false);
    return Observer(builder: (context) {
      if (authenticateController.currentUser == null ||
          authenticateController.currentUser.erros[0].isNotEmpty) {
        return Login();
      } else {
        return ListStudants(
          cpf: authenticateController.currentUser.data.cpf,
          token: authenticateController.currentUser.data.token,
        );
      }
    });
  }
}
