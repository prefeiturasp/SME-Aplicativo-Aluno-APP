import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'note.dart';

class NotesBody extends StatelessWidget {
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

  NotesBody(
      {required this.title,
      required this.bUm,
      required this.bDois,
      required this.bTres,
      required this.bQuatro,
      required this.bFinal,
      required this.descUm,
      required this.descDois,
      required this.descTres,
      required this.descQuatro,
      required this.descFinal,
      required this.corUm,
      required this.corDois,
      required this.corTres,
      required this.corQuatro,
      required this.corFinal,
      required this.groupSchool,});

  Row _buildGroupNonEJA() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Note(
            current: bDois == '-' && bTres == '-' && bQuatro == '-' && bFinal == '-' && bUm != '-' ? true : false,
            name: '1º Bim',
            noteValue: bUm,
            color: corUm,
            description: descUm,
          ),
          Note(
            current: bTres == '-' && bQuatro == '-' && bFinal == '-' && bDois != '-' ? true : false,
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
      );

  Row _buildGroupEJA() => Row(
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
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.5),
      child: ListTile(
          title: AutoSizeText(
            title,
            minFontSize: 13,
            maxFontSize: 15,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Padding(
              padding: EdgeInsets.all(screenHeight * 0.5),
              child: groupSchool != 'EJA' ? _buildGroupNonEJA() : _buildGroupEJA(),),),
    );
  }
}

class ModelTest {
  String name;
  bool current;

  ModelTest({required this.name, required this.current});
}
