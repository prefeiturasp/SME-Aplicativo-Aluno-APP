import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/string_support.dart';

class EAEstudanteCard extends StatelessWidget {
  final int codigoEOL;
  final String name;
  final String schoolName;
  final String schooType;
  final String dreName;
  final String studentGrade;
  final VoidCallback onPress;
  final Image? avatar;

  EAEstudanteCard(
      {required this.codigoEOL,
      required this.name,
      required this.schoolName,
      required this.dreName,
      required this.studentGrade,
      required this.onPress,
      required this.schooType,
      this.avatar,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(screenHeight * 2),
        margin: EdgeInsets.only(bottom: screenHeight * 1.5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
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
                    margin: EdgeInsets.only(right: screenHeight * 1.5),
                    child: avatar != null
                        ? avatar
                        : ClipOval(
                            child: Image.asset(
                              'assets/images/avatar_estudante.png',
                              width: screenHeight * 8,
                              height: screenHeight * 8,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Container(
                    width: size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: AutoSizeText(
                            StringSupport.truncateEndString(name, 28),
                            maxFontSize: 12,
                            minFontSize: 10,
                            style: TextStyle(color: Colors.black),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        AutoSizeText(
                          // "$schooType ${StringSupport.truncateEndString(schoolName, 30)} ($dreName)",
                          '$schooType ${StringSupport.truncateEndString(schoolName, 20)} ($dreName)',
                          maxFontSize: 10,
                          minFontSize: 8,
                          style: TextStyle(color: Color(0xff666666)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        AutoSizeText(
                          'TURMA $studentGrade',
                          maxFontSize: 10,
                          minFontSize: 8,
                          style: TextStyle(color: Color(0xffBBBDC9)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        AutoSizeText(
                          'CÓDIGO EOL $codigoEOL',
                          maxFontSize: 10,
                          minFontSize: 8,
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
            ),
          ],
        ),
      ),
    );
  }
}
