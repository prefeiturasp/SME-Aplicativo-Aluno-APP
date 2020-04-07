import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/students/widgets/cards/card_students.dart';
import 'package:sme_app_aluno/widgets/tag/tag_custom.dart';

class ListStudants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Estudantes"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: Container(
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
            TagCustom(text: "FUNDAMENTAL", color: Color(0xffC65D00)),
            CardStudent(),
            CardStudent(),
            CardStudent(),
          ],
        ),
      ),
    );
  }
}
