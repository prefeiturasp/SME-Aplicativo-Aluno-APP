import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/notes/note.dart';

class CorpoNotas extends StatelessWidget {
  final String title;
  final String bUm;
  final String bDois;
  final String bTres;
  final String bQuatro;
  final String bFinal;
  final String descUm;
  final String descDois;
  final String descTres;
  final String descQuatro;
  final String descFinal;
  final Color corUm;
  final Color corDois;
  final Color corTres;
  final Color corQuatro;
  final Color corFinal;
  final String groupSchool;

  CorpoNotas({
    this.title,
    this.bUm,
    this.bDois,
    this.bTres,
    this.bQuatro,
    this.bFinal,
    this.descUm,
    this.descDois,
    this.descTres,
    this.descQuatro,
    this.descFinal,
    this.corUm,
    this.corDois,
    this.corTres,
    this.corQuatro,
    this.corFinal,
    this.groupSchool,
  });

  _buildGroupNonEJA() => Padding(
        padding: const EdgeInsets.all(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Note(
              current: bDois == '-' &&
                      bTres == '-' &&
                      bQuatro == '-' &&
                      bFinal == '-' &&
                      bUm != '-'
                  ? true
                  : false,
              name: '1º Bim',
              noteValue: bUm,
              color: corUm,
              description: descUm,
            ),
            Note(
              current: bTres == '-' &&
                      bQuatro == '-' &&
                      bFinal == '-' &&
                      bDois != '-'
                  ? true
                  : false,
              name: '2º Bim',
              noteValue: bDois,
              color: corDois,
              description: descDois,
            ),
            Note(
              current: bQuatro == '-' && bTres != '-' ? true : false,
              name: '3º Bim',
              noteValue: bTres,
              color: corTres,
              description: descTres,
            ),
            Note(
              current: bFinal == '-' && bQuatro != '-' ? true : false,
              name: '4º Bim',
              noteValue: bQuatro,
              color: corQuatro,
              description: descQuatro,
            ),
            Note(
              current: bFinal != '-' ? true : false,
              name: 'Final',
              noteValue: bFinal,
              color: corFinal,
              description: descFinal,
            ),
          ],
        ),
      );

  _buildGroupEJA() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Note(
            current: bDois == '-' && bUm != '-' ? true : false,
            name: '1º Bim',
            noteValue: bUm,
            color: corUm,
            description: descUm,
          ),
          Note(
            current: bFinal == '-' && bDois != '-' ? true : false,
            name: '2º Bim',
            noteValue: bDois,
            color: corDois,
            description: descDois,
          ),
          Note(
            current: bFinal != '-' ? true : false,
            name: 'Final',
            noteValue: bFinal,
            color: corFinal,
            description: descFinal,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.4),
      child: ListTile(
        title: AutoSizeText(
          title,
          minFontSize: 12,
          maxFontSize: 14,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(screenHeight * 0.4),
          child: groupSchool != 'EJA' ? _buildGroupNonEJA() : _buildGroupEJA(),
        ),
      ),
    );
  }
}

class ModelTest {
  String name;
  bool current;

  ModelTest({this.name, this.current});
}
