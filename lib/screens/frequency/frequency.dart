import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sme_app_aluno/controllers/frequency/frequency.controller.dart';
import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/box_frequency.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/label_frequency.dart';
import 'package:sme_app_aluno/screens/widgets/cards/frequency_global_card.dart';
import 'package:sme_app_aluno/screens/widgets/cards/shimmer_card.dart';

class Frequency extends StatefulWidget {
  final Student student;
  final int userId;

  Frequency({
    @required this.student,
    @required this.userId,
  });

  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  FrequencyController _frequencyController;

  final anoLetivo = new DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _frequencyController = FrequencyController();
    _frequencyController.fetchFrequency(
      anoLetivo,
      widget.student.codigoEscola,
      widget.student.codigoTurma.toString(),
      widget.student.codigoEol.toString(),
      widget.userId,
    );
  }

  List<Map<String, dynamic>> _boxes =
      List.generate(4, (index) => {'isExpanded': false});

  Widget _listBoxBimestre(
    CurricularComponent data,
    bool aulas,
    bool faltas,
    bool compensacoes,
  ) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.frequenciasPorBimestre.length; i++) {
      if (aulas) {
        list.add(BoxFrequency(
          title: "${data.frequenciasPorBimestre[i].bimestre}º Bim.",
          idbox: "${data.frequenciasPorBimestre[i].quantidadeAulas}",
          fail: false,
        ));
      }
      if (faltas) {
        list.add(BoxFrequency(
          title: "${data.frequenciasPorBimestre[i].bimestre}º Bim.",
          idbox: "${data.frequenciasPorBimestre[i].quantidadeFaltas}",
          fail: true,
          ausencias: data.frequenciasPorBimestre[i].ausencias,
        ));
      }
      if (compensacoes) {
        list.add(BoxFrequency(
          title: "${data.frequenciasPorBimestre[i].bimestre}º Bim.",
          idbox: "${data.frequenciasPorBimestre[i].quantidadeCompensacoes}",
          fail: false,
        ));
      }
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
  }

  Widget _rowFrequency(
    double screenHeight,
    String label,
    CurricularComponent data,
    bool aulas,
    bool faltas,
    bool compensacoes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFrequency(text: label),
        SizedBox(
          height: screenHeight * 2,
        ),
        _listBoxBimestre(
          data,
          aulas,
          faltas,
          compensacoes,
        ),
        SizedBox(
          height: screenHeight * 2,
        ),
      ],
    );
  }

  Widget _listProgressBar(
    CurricularComponent data,
    double screenHeight,
  ) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.frequenciasPorBimestre.length; i++) {
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "${data.frequenciasPorBimestre[i].bimestre}º Bimestre",
            maxFontSize: 13,
            minFontSize: 11,
            style: TextStyle(
              color: Color(0xff757575),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: screenHeight * 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinearPercentIndicator(
                width: screenHeight * 36,
                lineHeight: 14.0,
                percent: data.frequenciasPorBimestre[i].frequencia / 100,
                backgroundColor: Color(0xffEDEDED),
                progressColor:
                    HexColor(data.frequenciasPorBimestre[i].corDaFrequencia),
              ),
              AutoSizeText(
                "${data.frequenciasPorBimestre[i].frequencia.toStringAsFixed(0)}%",
                maxFontSize: 13,
                minFontSize: 11,
                style: TextStyle(
                  color: Color(0xff757575),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 2.5,
          ),
        ],
      ));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(screenHeight * 2.5),
      child: Column(
        children: [
          Observer(builder: (context) {
            if (_frequencyController.loadingFrequency) {
              return ShimmerCard();
            } else {
              return FrequencyGlobalCard(
                  frequency: _frequencyController.frequency);
            }
          }),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          Observer(builder: (context) {
            if (_frequencyController.loadingFrequency) {
              return ShimmerCard();
            } else {
              if (_frequencyController.frequency != null) {
                return Container(
                  height: screenHeight * 60,
                  child: ListView.builder(
                      itemCount: _frequencyController
                          .frequency.componentesCurricularesDoAluno.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 2.5),
                          child: ExpansionPanelList(
                            expansionCallback:
                                (int index, bool isExpanded) async {
                              await _frequencyController.showCard(index);
                              setState(() {});
                              bool isExpanded = _frequencyController
                                  .frequency
                                  .componentesCurricularesDoAluno[index]
                                  .isExpanded;
                              if (isExpanded) {
                                _frequencyController.fetchCurricularComponent(
                                    anoLetivo,
                                    widget.student.codigoEscola,
                                    widget.student.codigoTurma.toString(),
                                    widget.student.codigoEol.toString(),
                                    _frequencyController
                                        .frequency
                                        .componentesCurricularesDoAluno[index]
                                        .codigoComponenteCurricular
                                        .toString());
                              }
                            },
                            children: [
                              ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return Container(
                                    padding: EdgeInsets.all(screenHeight * 2.5),
                                    width: MediaQuery.of(context).size.width,
                                    child: AutoSizeText(
                                      "${_frequencyController.frequency.componentesCurricularesDoAluno[index].descricaoComponenteCurricular}",
                                      maxFontSize: 20,
                                      minFontSize: 18,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                                body: Container(
                                  height: screenHeight * 100,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                      color: Color(0xffDBDBDB),
                                      width: 1.0,
                                    ),
                                  )),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Observer(builder: (context) {
                                        if (_frequencyController
                                            .loadingCurricularComponent) {
                                          return ShimmerCard();
                                        } else {
                                          return Container(
                                            padding: EdgeInsets.all(
                                                screenHeight * 2),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _rowFrequency(
                                                  screenHeight,
                                                  "Quantidade de aulas",
                                                  _frequencyController
                                                      .curricularComponent,
                                                  true,
                                                  false,
                                                  false,
                                                ),
                                                _rowFrequency(
                                                  screenHeight,
                                                  "Quantidade de ausências",
                                                  _frequencyController
                                                      .curricularComponent,
                                                  false,
                                                  true,
                                                  false,
                                                ),
                                                _rowFrequency(
                                                  screenHeight,
                                                  "Ausências compensadas",
                                                  _frequencyController
                                                      .curricularComponent,
                                                  false,
                                                  false,
                                                  true,
                                                ),
                                                LabelFrequency(
                                                    text:
                                                        "Percentual de frequência"),
                                                SizedBox(
                                                  height: screenHeight * 2,
                                                ),
                                                _listProgressBar(
                                                  _frequencyController
                                                      .curricularComponent,
                                                  screenHeight,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                                isExpanded: _frequencyController
                                    .frequency
                                    .componentesCurricularesDoAluno[index]
                                    .isExpanded,
                              )
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return AutoSizeText("não existe ");
              }
            }
          }),
        ],
      ),
    );
  }
}
