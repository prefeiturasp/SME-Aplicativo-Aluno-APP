import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/estudante.model.dart';
import '../../index.dart';

class EAResumoEstudanteCard extends StatelessWidget {
  final EstudanteModel estudante;
  final String modalidade;
  final String codigoGrupo;
  const EAResumoEstudanteCard({
    super.key,
    required this.estudante,
    required this.modalidade,
    required this.codigoGrupo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 1),
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
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: screenHeight * 2,
              bottom: screenHeight * 2,
              left: screenHeight * 2.5,
              right: screenHeight * 2.5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffEFB330),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 2),
                topRight: Radius.circular(screenHeight * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: screenHeight * 3,
                      width: screenHeight * 3,
                      margin: EdgeInsets.only(right: screenHeight * 1),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.userCircle,
                          size: screenHeight * 3,
                        ),
                      ),
                    ),
                    const AutoSizeText(
                      'ESTUDANTE',
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            ),
          ),
          EAEstudanteInfo(
            nome: estudante.nomeSocial.isNotEmpty ? estudante.nomeSocial : estudante.nome,
            ue: estudante.escola,
            tipoEscola: estudante.descricaoTipoEscola,
            dre: estudante.siglaDre,
            grade: estudante.turma,
            codigoEOL: estudante.codigoEol,
            modalidade: modalidade,
            padding: EdgeInsets.all(screenHeight * 2.5),
          ),
          Container(
            padding: EdgeInsets.only(
              left: screenHeight * 2.5,
              top: screenHeight * 2.5,
              right: screenHeight * 2.5,
              bottom: screenHeight * 1.5,
            ),
            child: Container(
              height: screenHeight * 6,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffC65D00), width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 3),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 3),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstudanteResumoView(
                        estudante: estudante,
                        modalidade: modalidade,
                        grupoCodigo: codigoGrupo,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const AutoSizeText(
                      'MAIS INFORMAÇÕES',
                      maxFontSize: 16,
                      minFontSize: 14,
                      style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: screenHeight * 3,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      color: const Color(0xffffd037),
                      size: screenHeight * 3,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
