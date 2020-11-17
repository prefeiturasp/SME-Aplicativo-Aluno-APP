import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/students/resume_studants/resume_studants.dart';
import 'package:sme_app_aluno/screens/widgets/student_info/student_info.dart';

class CardResumeStudent extends StatelessWidget {
  final Student student;
  final int userId;

  CardResumeStudent({@required this.student, @required this.userId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            decoration: BoxDecoration(
                color: Color(0xffEFB330),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              children: <Widget>[
                Container(
                  height: screenHeight * 4,
                  width: screenHeight * 4,
                  margin: EdgeInsets.only(right: screenHeight * 1),
                  decoration: BoxDecoration(
                    color: Color(0xffEFB330),
                    border: Border.all(
                      width: screenHeight * 0.3,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenHeight * 2),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                      size: screenHeight * 2,
                    ),
                  ),
                ),
                AutoSizeText(
                  "ESTUDANTE",
                  maxFontSize: 18,
                  minFontSize: 16,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          StudentInfo(
            studentName:
                student.nomeSocial != null && student.nomeSocial.isNotEmpty
                    ? student.nomeSocial
                    : student.nome,
            schoolName: student.escola,
            schoolType: student.descricaoTipoEscola,
            studentEOL: student.codigoEol,
            padding: EdgeInsets.all(screenHeight * 2.5),
          ),
          Container(
            padding: EdgeInsets.only(
                left: screenHeight * 2.5,
                top: screenHeight * 2.5,
                right: screenHeight * 2.5,
                bottom: screenHeight * 1.5),
            child: Container(
              height: screenHeight * 6,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffC65D00), width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 3),
                ),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResumeStudants(
                                student: student,
                                userId: userId,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "MAIS INFORMAÇÕES",
                      maxFontSize: 16,
                      minFontSize: 14,
                      style: TextStyle(
                          color: Color(0xffC65D00),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: screenHeight * 3,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Color(0xffffd037),
                      size: screenHeight * 3,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
