import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardStudent extends StatelessWidget {
  final String name;
  final String schoolName;
  final String studentGrade;
  final Function onPress;
  final Image avatar;

  CardStudent(
      {@required this.name,
      @required this.schoolName,
      @required this.studentGrade,
      @required this.onPress,
      this.avatar});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(screenHeight * 2),
        margin: EdgeInsets.only(top: screenHeight * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(screenHeight * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: screenHeight * 4),
                      width: screenHeight * 8,
                      height: screenHeight * 8,
                      decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius:
                              BorderRadius.circular(screenHeight * 4)),
                      child: avatar != null
                          ? avatar
                          : Image.asset("assets/images/avatar_estudante.png")),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          name,
                          maxFontSize: 14,
                          minFontSize: 12,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        AutoSizeText(
                          schoolName,
                          maxFontSize: 12,
                          minFontSize: 10,
                          style: TextStyle(color: Color(0xff666666)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        AutoSizeText(
                          "TURMA $studentGrade",
                          maxFontSize: 12,
                          minFontSize: 10,
                          style: TextStyle(color: Color(0xffBBBDC9)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.chevronRight,
              color: Color(0xffffd037),
              size: screenHeight * 3,
            )
          ],
        ),
      ),
    );
  }
}
