import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardMessage extends StatelessWidget {
  final String headerTitle;
  final bool headerIcon;
  final List<Widget> content;
  final bool recentMessage;
  final bool footer;
  final List<Widget> footerContent;
  final String categoriaNotificacao;

  const CardMessage(
      {super.key, required this.headerTitle,
      required this.headerIcon,
      required this.content,
      required this.recentMessage,
      required this.footer,
      required this.footerContent,
      required this.categoriaNotificacao,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorSME = Color(0xff9C33AD);
    const colorUE = Color(0xff5151CF);
    const colorTURMA = Color(0xff599E00);
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            decoration: BoxDecoration(
                color: recentMessage
                    ? categoriaNotificacao == 'SME'
                        ? colorSME
                        : categoriaNotificacao == 'UE'
                            ? colorUE
                            : colorTURMA
                    : categoriaNotificacao == 'SME'
                        ? colorSME.withOpacity(0.4)
                        : categoriaNotificacao == 'UE'
                            ? colorUE.withOpacity(0.4)
                            : colorTURMA.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2), topRight: Radius.circular(screenHeight * 2),),),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: headerIcon ? headerIcon : false,
                        child: Container(
                          margin: EdgeInsets.only(right: screenHeight * 2),
                          child: Icon(
                            recentMessage ? FontAwesomeIcons.envelope : FontAwesomeIcons.envelopeOpen,
                            color: recentMessage
                                ? const Color(0xffFFD869)
                                : categoriaNotificacao == 'SME'
                                    ? colorSME
                                    : categoriaNotificacao == 'UE'
                                        ? colorUE
                                        : colorTURMA,
                            size: screenHeight * 2.7,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        headerTitle,
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                            color: recentMessage
                                ? Colors.white
                                : categoriaNotificacao == 'SME'
                                    ? colorSME
                                    : categoriaNotificacao == 'UE'
                                        ? colorUE
                                        : colorTURMA,
                            fontWeight: FontWeight.w700,),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !recentMessage,
                  child: SizedBox(
                      width: screenHeight * 3.5,
                      height: screenHeight * 3.5,
                      child: ClipOval(
                          child: Container(
                        color: categoriaNotificacao == 'SME'
                            ? colorSME
                            : categoriaNotificacao == 'UE'
                                ? colorUE
                                : colorTURMA,
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: const Color(0xffFFFFFF),
                          size: screenHeight * 2,
                        ),
                      ),),),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(screenHeight * 1.3),
            color: Colors.white,
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
                ),
              ],
            ),
          ),
          Visibility(
            visible: footer,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF3F3F3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenHeight * 2), bottomRight: Radius.circular(screenHeight * 2),),
              ),
              padding: EdgeInsets.only(
                  left: screenHeight * 2.5,
                  right: screenHeight * 2.5,
                  top: screenHeight * 1.5,
                  bottom: screenHeight * 1.5,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: footerContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
