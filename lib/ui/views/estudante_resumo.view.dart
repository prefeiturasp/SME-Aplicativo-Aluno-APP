import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/screens/data_student/data.dart';
import 'package:sme_app_aluno/screens/frequency/frequency.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/notes/expansion.dart';
import 'package:sme_app_aluno/ui/index.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/date_format.dart';

class EstudanteResumoView extends StatefulWidget {
  final EstudanteModel estudante;
  final int userId;
  final String modalidade;

  EstudanteResumoView({@required this.estudante, this.modalidade, this.userId});

  @override
  _EstudanteResumoViewState createState() => _EstudanteResumoViewState();
}

class _EstudanteResumoViewState extends State<EstudanteResumoView> {
  bool abaDados = true;
  bool abaBoletim = false;
  bool abaFrequencia = false;

  content(BuildContext context, double screenHeight, EstudanteModel data) {
    String dateFormatted =
        DateFormatSuport.formatStringDate(data.dataNascimento, 'dd/MM/yyyy');
    String dateSituacaoMatricula = DateFormatSuport.formatStringDate(
        data.dataSituacaoMatricula, 'dd/MM/yyyy');

    if (abaDados) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: DataStudent(
          dataNasc: dateFormatted,
          codigoEOL: "${data.codigoEol}",
          situacao: dateSituacaoMatricula,
          codigoUe: widget.estudante.codigoEscola,
        ),
      );
    }

    if (abaBoletim) {
      return Container(
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: Expansion(
          codigoUe: widget.estudante.codigoEscola,
          codigoTurma: widget.estudante.codigoTurma.toString(),
          codigoAluno: widget.estudante.codigoEol.toString(),
          groupSchool: widget.modalidade,
        ),
        height: MediaQuery.of(context).size.height - screenHeight * 26,
      );
    }

    if (abaFrequencia) {
      return Frequency(
        student: widget.estudante,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      // BackgroundFetch.stop().then((int status) {
      //   print('[BackgroundFetch] stop success: $status');
      // });
      return NotInteernet();
    } else {
      var size = MediaQuery.of(context).size;
      var screenHeight =
          (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title: Text(
            "Informações do estudante",
            style: TextStyle(
                color: Color(0xff333333), fontWeight: FontWeight.w500),
          ),
          backgroundColor: Color(0xffEEC25E),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffE5E5E5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(screenHeight * 2.5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffC5C5C5), width: 0.5))),
                      child: EAEstudanteInfo(
                        nome: widget.estudante.nomeSocial != null &&
                                widget.estudante.nomeSocial.isNotEmpty
                            ? widget.estudante.nomeSocial
                            : widget.estudante.nome,
                        ue: widget.estudante.escola,
                        tipoEscola: widget.estudante.descricaoTipoEscola,
                        dre: widget.estudante.siglaDre,
                        grade: widget.estudante.turma,
                        codigoEOL: widget.estudante.codigoEol,
                      ),
                    ),
                    Container(
                        child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = true;
                              abaBoletim = false;
                              abaFrequencia = false;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) *
                                33.33,
                            padding: EdgeInsets.only(
                                top: screenHeight * 2.2,
                                bottom: screenHeight * 2.2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: abaDados
                                          ? Color(0xffC65D00)
                                          : Color(0xffCECECE),
                                      width: 2)),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "DADOS",
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                    color: abaDados
                                        ? Color(0xffC65D00)
                                        : Color(0xff9f9f9f),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = false;
                              abaBoletim = true;
                              abaFrequencia = false;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) *
                                33.33,
                            padding: EdgeInsets.only(
                                top: screenHeight * 2.2,
                                bottom: screenHeight * 2.2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: abaBoletim
                                          ? Color(0xffC65D00)
                                          : Color(0xffCECECE),
                                      width: 2)),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "BOLETIM",
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                    color: abaBoletim
                                        ? Color(0xffC65D00)
                                        : Color(0xff9f9f9f),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = false;
                              abaBoletim = false;
                              abaFrequencia = true;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) *
                                33.33,
                            padding: EdgeInsets.only(
                              top: screenHeight * 2.2,
                              bottom: screenHeight * 2.2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: abaFrequencia
                                          ? Color(0xffC65D00)
                                          : Color(0xffCECECE),
                                      width: 2)),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "FREQUÊNCIA",
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                    color: abaFrequencia
                                        ? Color(0xffC65D00)
                                        : Color(0xff9f9f9f),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                    content(context, screenHeight, widget.estudante)
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
