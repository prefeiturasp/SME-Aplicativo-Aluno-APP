import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardResumeStudent extends StatelessWidget {
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
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: screenHeight * 2.5,
                  ),
                  width: screenHeight * 8,
                  height: screenHeight * 8,
                  decoration: BoxDecoration(
                    color: Color(0xffC4C4C4),
                    borderRadius: BorderRadius.circular(screenHeight * 4),
                  ),
                  child: Image.asset(
                    "assets/images/avatar_estudante.png",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 1.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        "ADRIA PEDRO GONZALES",
                        maxFontSize: 16,
                        minFontSize: 14,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      AutoSizeText(
                        "EMEF JARDIM ELIANA",
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
          ),
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffC65D00), width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 4),
                ),
              ),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "VER HISTÓRICO COMPLETO",
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
