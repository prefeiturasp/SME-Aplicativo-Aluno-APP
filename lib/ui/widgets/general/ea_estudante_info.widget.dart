import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EAEstudanteInfo extends StatelessWidget {
  final String nome;
  final String ue;
  final String tipoEscola;
  final String dre;
  final String? grade;
  final int? codigoEOL;
  final Widget? avatar;
  final String? modalidade;
  final EdgeInsets? padding;

  EAEstudanteInfo({super.key, 
    required this.nome,
    required this.ue,
    required this.tipoEscola,
    required this.dre,
    this.codigoEOL,
    this.grade,
    this.avatar,
    this.modalidade,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: padding ?? const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: screenHeight * 2.5,
            ),
            child: avatar ?? ClipOval(
                    child: Image.asset(
                      'assets/images/avatar_estudante.png',
                      width: screenHeight * 8,
                      height: screenHeight * 8,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Container(
            width: (screenWidth / 1.95),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  nome,
                  // StringSupport.truncateEndString(nome, 25),
                  maxFontSize: 16,
                  minFontSize: 14,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
                AutoSizeText(
                  '$tipoEscola $ue ($dre)',
                  maxFontSize: 12,
                  minFontSize: 10,
                  style: const TextStyle(
                    color: Color(0xffC4C4C4),
                  ),
                  maxLines: 2,
                ),
                modalidade != null
                    ? AutoSizeText(
                        '${modalidade!.toUpperCase()}',
                        maxFontSize: 12,
                        minFontSize: 10,
                        style: const TextStyle(
                          color: Color(0xffC4C4C4),
                        ),
                        maxLines: 2,
                      )
                    : const SizedBox(),
                Visibility(
                  visible: grade != null,
                  child: AutoSizeText(
                    'TURMA $grade',
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: const TextStyle(color: Color(0xffBBBDC9), fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                ),
                Visibility(
                  visible: codigoEOL != null,
                  child: AutoSizeText(
                    'COD. EOL: $codigoEOL',
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: const TextStyle(color: Color(0xff757575), fontWeight: FontWeight.w500),
                    maxLines: 2,
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
