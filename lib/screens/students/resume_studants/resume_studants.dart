import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/widgets/student_info/student_info.dart';

class ResumeStudants extends StatelessWidget {
  final Student student;

  ResumeStudants({@required this.student});

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Informações do estudante"),
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
                      studentName: student.nomeSocial != null
                          ? student.nomeSocial
                          : student.nome,
                      schoolName: student.escola,
                    ),
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width / 100) * 33.33,
                          padding: EdgeInsets.only(
                              top: screenHeight * 2.2,
                              bottom: screenHeight * 2.2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffC65D00), width: 2)),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "DADOS",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Color(0xffC65D00),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width / 100) * 33.33,
                          padding: EdgeInsets.only(
                              top: screenHeight * 2.2,
                              bottom: screenHeight * 2.2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffCECECE), width: 2)),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "BOLETIM",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Color(0xffCECECE),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width:
                              (MediaQuery.of(context).size.width / 100) * 33.33,
                          padding: EdgeInsets.only(
                            top: screenHeight * 2.2,
                            bottom: screenHeight * 2.2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffCECECE), width: 2)),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "FREQUÊNCIA",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Color(0xffCECECE),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(screenHeight * 2.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        itemResume(context, "Data de Nascimento", "30/09/1984",
                            screenHeight),
                        SizedBox(
                          height: screenHeight * 2.5,
                        ),
                        itemResume(context, "Código EOL",
                            "${student.codigoEol}", screenHeight),
                        SizedBox(
                          height: screenHeight * 2.5,
                        ),
                        itemResume(context, "Situação",
                            "Matriculado em 04/02/2019", screenHeight),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
