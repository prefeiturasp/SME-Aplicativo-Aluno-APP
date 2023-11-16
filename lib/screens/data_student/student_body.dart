import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StudentBody extends StatelessWidget {
  final String dataNasc;
  final String codigoEOL;
  final String situacao;

  const StudentBody({super.key, required this.dataNasc,required this.codigoEOL,required this.situacao});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    Widget itemResume(BuildContext context, String infoName, String infoData,
        double screenHeight,) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              infoName,
              maxFontSize: 16,
              minFontSize: 14,
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: AutoSizeText(
                infoData,
                maxFontSize: 20,
                minFontSize: 18,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 3, top: screenHeight * 1,),
            child: const AutoSizeText(
              'Dados do estudante',
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                  color: Color(0xFFC65D00), fontWeight: FontWeight.bold,),
              textAlign: TextAlign.left,
            ),
          ),
          itemResume(context, 'Data de Nascimento', dataNasc, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          itemResume(context, 'Código EOL', codigoEOL, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          itemResume(
              context, 'Situação', 'Matriculado em $situacao', screenHeight,),
        ],
      ),
    );
  }
}
