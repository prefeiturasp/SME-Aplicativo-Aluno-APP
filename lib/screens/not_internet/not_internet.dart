import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NotInteernet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text('Mensagem importante'),
        backgroundColor: Color(0xffEEC25E),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(screenHeight * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.wifi,
              size: screenHeight * 10,
              color: Color(0xffFFD037),
            ),
            SizedBox(
              height: screenHeight * 2,
            ),
            AutoSizeText(
              'Sua internet parece não estar funcionando corretamente. Vá para um ambiente com internet para navegar no aplicativo',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.3, color: Color(0xff333333)),
              maxFontSize: 20,
              minFontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
