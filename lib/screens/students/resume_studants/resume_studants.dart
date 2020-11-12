import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/frequency/frequency.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/screens/widgets/student_info/student_info.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/utils/date_format.dart';

class ResumeStudants extends StatefulWidget {
  final Student student;

  ResumeStudants({@required this.student});

  @override
  _ResumeStudantsState createState() => _ResumeStudantsState();
}

class _ResumeStudantsState extends State<ResumeStudants> {
  bool abaDados = true;
  bool abaBoletim = false;
  bool abaFrequencia = false;
  Widget itemResume(BuildContext context, String infoName, String infoData,
      double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            infoName,
            maxFontSize: 18,
            minFontSize: 16,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: screenHeight * 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(screenHeight * 3),
            decoration: BoxDecoration(color: Colors.white),
            child: AutoSizeText(
              infoData,
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  content(BuildContext context, double screenHeight, Student data) {
    String dateFormatted =
        DateFormatSuport.formatStringDate(data.dataNascimento, 'dd/MM/yyyy');
    String dateSituacaoMatricula = DateFormatSuport.formatStringDate(
        data.dataSituacaoMatricula, 'dd/MM/yyyy');

    if (abaDados) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            itemResume(
                context, "Data de Nascimento", "$dateFormatted", screenHeight),
            SizedBox(
              height: screenHeight * 2.5,
            ),
            itemResume(
                context, "Código EOL", "${data.codigoEol}", screenHeight),
            SizedBox(
              height: screenHeight * 2.5,
            ),
            itemResume(context, "Situação",
                "Matriculado em $dateSituacaoMatricula", screenHeight),
          ],
        ),
      );
    }

    if (abaBoletim) {
      return Container(
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: CardAlert(
          isHeader: false,
          icon: Icon(
            FontAwesomeIcons.envelopeOpen,
            color: Color(0xffFFD037),
            size: screenHeight * 8,
          ),
          text:
              "Em breve você terá acesso ao boletim do estudante neste espaço. Aguarde as próximas atualizações do aplicativo.",
          textSize: 20,
        ),
      );
    }

    if (abaFrequencia) {
      return Frequency();
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
        backgroundColor: Colors.white,
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
            height: MediaQuery.of(context).size.height,
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
                      child: StudentInfo(
                        studentName: widget.student.nomeSocial != null &&
                                widget.student.nomeSocial.isNotEmpty
                            ? widget.student.nomeSocial
                            : widget.student.nome,
                        schoolName: widget.student.escola,
                        schoolType: widget.student.descricaoTipoEscola,
                        studentGrade: widget.student.turma,
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
                    content(context, screenHeight, widget.student)
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
