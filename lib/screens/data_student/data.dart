import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/ue.controller.dart';
import 'student_body.dart';
import 'ue_body.dart';

class DataStudent extends StatefulWidget {
  final String dataNasc;
  final String codigoEOL;
  final String situacao;
  final String codigoUe;

  const DataStudent({
    super.key,
    required this.dataNasc,
    required this.codigoEOL,
    required this.situacao,
    required this.codigoUe,
  });

  @override
  DataStudentState createState() => DataStudentState();
}

class DataStudentState extends State<DataStudent> {
  final UEController _ueController = UEController();

  @override
  void initState() {
    super.initState();
    loadUE();
  }

  void loadUE() async {
    _ueController.loadingUE(widget.codigoUe);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudentBody(
          dataNasc: widget.dataNasc,
          codigoEOL: widget.codigoEOL,
          situacao: widget.situacao,
        ),
        Observer(
          builder: (context) {
            if (_ueController.isLoading) {
              return Container(
                margin: EdgeInsets.all(screenHeight * 1.5),
                child: const GFLoader(
                  type: GFLoaderType.square,
                  loaderColorOne: Color(0xffDE9524),
                  loaderColorTwo: Color(0xffC65D00),
                  loaderColorThree: Color(0xffC65D00),
                  size: GFSize.LARGE,
                ),
              );
            } else {
              if (_ueController.dadosUE != null) {
                return UEBody(
                  dadosUE: _ueController.dadosUE!,
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight * 2),
                  child: Container(
                    padding: EdgeInsets.all(screenHeight * 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFD037),
                      borderRadius: BorderRadius.all(Radius.circular(screenHeight * 2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: screenHeight * 2),
                          child: Icon(
                            FontAwesomeIcons.flag,
                            color: const Color(0xffC45C04),
                            size: screenHeight * 2.7,
                          ),
                        ),
                        const AutoSizeText(
                          'Dados da Unidade Escolar não disponível',
                          maxFontSize: 18,
                          minFontSize: 16,
                          style: TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
