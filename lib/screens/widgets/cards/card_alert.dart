import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardAlert extends StatelessWidget {
  final String title;
  final Icon icon;
  final String text;

  CardAlert({this.title, this.icon, this.text});

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
                color: Color(0xffFFD037),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: screenHeight * 2),
                  child: Icon(
                    FontAwesomeIcons.envelopeOpen,
                    color: Color(0xffC45C04),
                    size: screenHeight * 2.7,
                  ),
                ),
                AutoSizeText(
                  "ALERTA DE NOTAS",
                  maxFontSize: 18,
                  minFontSize: 16,
                  style: TextStyle(
                      color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(screenHeight * 2.5),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 1.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    SizedBox(
                      height: screenHeight * 2,
                    ),
                    Container(
                        width: screenHeight * 41,
                        child: Center(
                          child: AutoSizeText(
                            text,
                            maxFontSize: 16,
                            minFontSize: 14,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
