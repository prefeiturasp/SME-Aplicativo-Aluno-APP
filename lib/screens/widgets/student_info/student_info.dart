import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  final String studentName;
  final String schoolName;
  final Widget avatar;
  final EdgeInsets padding;

  StudentInfo(
      {@required this.studentName,
      @required this.schoolName,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: EdgeInsets.only(top: screenHeight * 1.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  studentName,
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                AutoSizeText(
                  schoolName,
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: TextStyle(
                    color: Color(0xff666666),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
