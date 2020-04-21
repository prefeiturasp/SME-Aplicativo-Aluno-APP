import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/screens/messages/messages.dart';

class CardRecentMessage extends StatelessWidget {
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
                color: Color(0xffE1771D),
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
                    color: Color(0xffFFD037),
                    size: screenHeight * 2.7,
                  ),
                ),
                AutoSizeText(
                  "MENSAGEM MAIS RECENTE",
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
            color: Color(0xffC45C04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 1.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        "ADRIA PEDRO GONZALES",
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: screenHeight * 1.8,
                      ),
                      Container(
                        width: screenHeight * 36,
                        child: AutoSizeText(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consectetur felis quis imperdiet congue. Suspendisse hendrerit placerat orci.",
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: screenHeight * 2.5,
                right: screenHeight * 2.5,
                top: screenHeight * 1.5,
                bottom: screenHeight * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: screenHeight * 6,
                    height: screenHeight * 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC65D00), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 3),
                      ),
                    ),
                    child: Icon(
                      FontAwesomeIcons.times,
                      color: Color(0xffC65D00),
                    ),
                  ),
                ),
                Container(
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
                                builder: (context) => Messages()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            "VER TODOS",
                            maxFontSize: 16,
                            minFontSize: 14,
                            style: TextStyle(
                                color: Color(0xffC65D00),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: screenHeight * 2,
                          ),
                          Icon(
                            FontAwesomeIcons.envelopeOpen,
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
          ),
        ],
      ),
    );
  }
}
