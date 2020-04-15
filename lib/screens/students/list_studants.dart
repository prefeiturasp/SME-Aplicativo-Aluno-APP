import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/students.controller.dart';
import 'package:sme_app_aluno/models/student.dart';
import 'package:sme_app_aluno/screens/dashboard/dashboard.dart';
import 'package:sme_app_aluno/screens/students/widgets/cards/card_students.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';

class ListStudants extends StatelessWidget {
  final String cpf;
  final String token;

  ListStudants({@required this.cpf, @required this.token});

  Widget _itemCardStudent(BuildContext context, Student model) {
    return CardStudent(
      name: "${model.nome}",
      schoolName: "${model.escola}",
      studentGrade: "${model.turma}",
      onPress: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      },
    );
  }

  Widget _listStudents(List<Student> students, BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < students.length; i++) {
      list.add(_itemCardStudent(context, students[i]));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    var studentsController =
        Provider.of<StudentsController>(context, listen: false);

    studentsController.loadingStudents(cpf, token);

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Estudantes"),
        backgroundColor: Color(0xffEEC25E),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 2.5,
              ),
              AutoSizeText(
                "ALUNOS CADASTRADOS PARA O RESPONSÁVEL",
                maxFontSize: 16,
                minFontSize: 14,
                style: TextStyle(
                    color: Color(0xffDE9524), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenHeight * 3.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: screenHeight * 74,
                child: Observer(builder: (context) {
                  if (studentsController.isLoading) {
                    return GFLoader(
                      type: GFLoaderType.square,
                      loaderColorOne: Color(0xffDE9524),
                      loaderColorTwo: Color(0xffC65D00),
                      loaderColorThree: Color(0xffC65D00),
                      size: GFSize.LARGE,
                    );
                  } else {
                    return ListView.builder(
                      itemCount: studentsController.listStudents.length,
                      itemBuilder: (context, index) {
                        final dados = studentsController.listStudents;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TagCustom(
                                text: "${dados[index].descricaoTipoEscola}",
                                color: Color(0xffC65D00)),
                            _listStudents(dados[index].student, context),
                          ],
                        );
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
