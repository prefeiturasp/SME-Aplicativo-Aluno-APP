import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/screens/drawer_menu/drawer_menu.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';

class Dashboard extends StatelessWidget {
  final Student student;

  Dashboard({@required this.student});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Resumo do Estudante"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 2.5,
              ),
              TagCustom(
                  text: student.descricaoTipoEscola,
                  color: Color(0xffEEC25E),
                  textColor: Color(0xffD06D12)),
              CardResumeStudent(
                student: student,
              ),
              CardRecentMessage(),
              CardAlert(
                title: "ALERTA DE NOTAS",
                icon: Icon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Color(0xffFFD037),
                  size: screenHeight * 6,
                ),
                text:
                    "Em breve, você terá alertas de notas neste espeço. Aguarde a próxima versão do aplicativo e atualize assim que estiver diponível",
              ),
              CardAlert(
                title: "ALERTA DE FREQUÊNCIA",
                icon: Icon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Color(0xffFFD037),
                  size: screenHeight * 6,
                ),
                text:
                    "Em breve, você terá alertas de frequência neste espeço. Aguarde a próxima versão do aplicativo e atualize assim que estiver diponível",
              )
            ],
          ),
        ),
      ),
      drawer: DrawerMenu(
        student: student,
      ),
    );
  }
}
