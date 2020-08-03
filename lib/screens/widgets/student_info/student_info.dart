import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/utils/string_support.dart';

class StudentInfo extends StatelessWidget {
  final String studentName;
  final String schoolName;
  final String schoolType;
  final String studentGrade;
  final int studentEOL;
  final Widget avatar;
  final EdgeInsets padding;

  StudentInfo(
      {@required this.studentName,
      @required this.schoolName,
      @required this.schoolType,
      this.studentEOL,
      this.studentGrade,
      this.avatar,
      this.padding});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      padding: padding != null ? padding : EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: screenHeight * 2.5,
            ),
            child: avatar != null
                ? avatar
                : ClipOval(
                    child: Image.asset(
                      "assets/images/avatar_estudante.png",
                      width: screenHeight * 8,
                      height: screenHeight * 8,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  StringSupport.truncateEndString(studentName, 25),
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: screenHeight * 30,
                  child: AutoSizeText(
                    "$schoolType $schoolName",
                    maxFontSize: 12,
                    minFontSize: 10,
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(0xffC4C4C4),
                    ),
                  ),
                ),
                Visibility(
                  visible: studentGrade != null,
                  child: AutoSizeText(
                    "TURMA $studentGrade",
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: TextStyle(
                        color: Color(0xffBBBDC9), fontWeight: FontWeight.w500),
                  ),
                ),
                Visibility(
                  visible: studentEOL != null,
                  child: AutoSizeText(
                    "COD. EOL: $studentEOL",
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: TextStyle(
                        color: Color(0xff757575), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
