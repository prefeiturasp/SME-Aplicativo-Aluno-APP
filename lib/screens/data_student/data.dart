import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:sme_app_aluno/controllers/ue/ue.controller.dart';
import 'package:sme_app_aluno/screens/data_student/student_body.dart';
import 'package:sme_app_aluno/screens/data_student/ue_body.dart';

class DataStudent extends StatefulWidget {
  final String dataNasc;
  final String codigoEOL;
  final String situacao;
  final String codigoUe;
  final int id;

  DataStudent(
      {this.dataNasc, this.codigoEOL, this.situacao, this.codigoUe, this.id});

  @override
  _DataStudentState createState() => _DataStudentState();
}

class _DataStudentState extends State<DataStudent> {
  UEController _ueController;

  @override
  void initState() {
    super.initState();
    loadUE();
  }

  loadUE() async {
    _ueController = UEController();
    _ueController.loadingUE(widget.codigoUe, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudentBody(
          dataNasc: widget.dataNasc,
          codigoEOL: widget.codigoEOL,
          situacao: widget.situacao,
        ),
        Observer(builder: (context) {
          if (_ueController.isLoading) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.square,
                loaderColorOne: Color(0xffDE9524),
                loaderColorTwo: Color(0xffC65D00),
                loaderColorThree: Color(0xffC65D00),
                size: GFSize.LARGE,
              ),
              margin: EdgeInsets.all(screenHeight * 1.5),
            );
          } else {
            if (_ueController.dadosUE != null) {
              return UEBody(
                dadosUE: _ueController.dadosUE,
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 2),
                child: Container(
                  padding: EdgeInsets.all(screenHeight * 2.5),
                  decoration: BoxDecoration(
                      color: Color(0xffFFD037),
                      borderRadius:
                          BorderRadius.all(Radius.circular(screenHeight * 2))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: screenHeight * 2),
                        child: Icon(
                          FontAwesomeIcons.flag,
                          color: Color(0xffC45C04),
                          size: screenHeight * 2.7,
                        ),
                      ),
                      AutoSizeText(
                        'Dados da Unidade Escolar não disponível',
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(
                            color: Color(0xffC45C04),
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        }),
      ],
    );
  }
}
