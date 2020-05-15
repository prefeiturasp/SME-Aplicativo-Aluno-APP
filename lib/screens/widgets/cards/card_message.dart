import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardMessage extends StatelessWidget {
  final String headerTitle;
  final bool headerIcon;
  final List<Widget> content;
  final bool recentMessage;
  final bool firstMessage;
  final bool footer;
  final List<Widget> footerContent;

  CardMessage(
      {this.headerTitle,
      this.headerIcon,
      this.content,
      this.recentMessage,
      this.firstMessage,
      this.footer,
      this.footerContent});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 4),
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
                color: recentMessage ? Color(0xffE1771D) : Color(0xffF8E8C2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: headerIcon ? headerIcon : false,
                  child: Container(
                    margin: EdgeInsets.only(right: screenHeight * 2),
                    child: Icon(
                      FontAwesomeIcons.envelopeOpen,
                      color: !recentMessage
                          ? Color(0xffE1771D)
                          : Color(0xffFFD037),
                      size: screenHeight * 2.7,
                    ),
                  ),
                ),
                AutoSizeText(
                  headerTitle,
                  maxFontSize: 18,
                  minFontSize: 16,
                  style: TextStyle(
                      color: recentMessage ? Colors.white : Color(0xffC65D00),
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            color: recentMessage ? Color(0xffC45C04) : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 1.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: content,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: footer,
            child: Container(
              decoration: BoxDecoration(
                color: recentMessage ? Colors.white : Color(0xffF3F3F3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenHeight * 2),
                    bottomRight: Radius.circular(screenHeight * 2)),
              ),
              padding: EdgeInsets.only(
                  left: screenHeight * 2.5,
                  right: screenHeight * 2.5,
                  top: screenHeight * 1.5,
                  bottom: screenHeight * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: footerContent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
