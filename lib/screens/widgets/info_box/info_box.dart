import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final List<Widget> content;
  final IconData icon;

  InfoBox({@required this.content, this.icon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(screenHeight * 2),
          margin:
              EdgeInsets.only(top: screenHeight * 5, bottom: screenHeight * 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffFFC6C8),
            ),
            borderRadius: BorderRadius.circular(screenHeight * 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content,
          ),
        ),
        Visibility(
          visible: icon != null,
          child: Positioned(
              top: screenHeight * 2.4,
              right: screenHeight * 2.5,
              child: Container(
                width: screenHeight * 5,
                height: screenHeight * 5,
                color: Color(0xffffffff),
                child: Icon(
                  icon,
                  size: screenHeight * 2.3,
                  color: Color(0xff666666),
                ),
              )),
        ),
      ],
    );
  }
}
