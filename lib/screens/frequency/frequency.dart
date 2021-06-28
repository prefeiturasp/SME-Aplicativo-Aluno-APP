import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sme_app_aluno/controllers/frequency/frequency.controller.dart';
import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/box_frequency.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/label_frequency.dart';
import 'package:sme_app_aluno/screens/widgets/cards/card_alert.dart';
import 'package:sme_app_aluno/screens/widgets/cards/frequency_global_card.dart';

class Frequency extends StatefulWidget {
  final EstudanteModel student;
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
    List<Widget> list = data?.frequenciasPorBimestre?.map((frequency) {
          if (aulas) {
            return new BoxFrequency(
              title: "${frequency.bimestre}º Bim.",
              idbox: "${frequency.quantidadeAulas}",
              fail: false,
            );
          }

          if (faltas) {
            return BoxFrequency(
              title: "${frequency.bimestre}º Bim.",
              idbox: "${frequency.quantidadeFaltas}",
              fail: true,
              ausencias: frequency.ausencias,
            );
          }

          if (compensacoes) {
            return BoxFrequency(
              title: "${frequency.bimestre}º Bim.",
              idbox: "${frequency.quantidadeCompensacoes}",
              fail: false,
            );
          }

          return Text("${frequency.bimestre}º Bim.");
        })?.toList() ??
        [];

    return Row(
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

  _buildLoadingWidget(size, screenHeight) => Container(
        child: GFLoader(
          type: GFLoaderType.square,
          loaderColorOne: Color(0xffDE9524),
          loaderColorTwo: Color(0xffC65D00),
          loaderColorThree: Color(0xffC65D00),
          size: GFSize.LARGE,
        ),
        margin: EdgeInsets.all(screenHeight * 1.5),
      );

  _buildFrequencyExpandedPanel(index, size, screenHeight) {
    var _comp =
        _frequencyController.frequency.componentesCurricularesDoAluno[index];

    return Container(
      padding: EdgeInsets.all(screenHeight * 2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rowFrequency(
              screenHeight,
              "Quantidade de aulas",
              _comp.curricularComponent,
              true,
              false,
              false,
            ),
            _rowFrequency(
              screenHeight,
              "Quantidade de ausências",
              _comp.curricularComponent,
              false,
              true,
              false,
            ),
            _rowFrequency(
              screenHeight,
              "Ausências compensadas",
              _comp.curricularComponent,
              false,
              false,
              true,
            ),
            LabelFrequency(text: "Percentual de frequência"),
            SizedBox(
              height: screenHeight * 2,
            ),
            _listProgressBar(
              _comp.curricularComponent,
              screenHeight,
            ),
            SizedBox(
              height: screenHeight * 2,
            ),
          ],
        ),
      ),
    );
  }

  _frequencyContainerBodyObserver(index, size, screenHeight) =>
      Observer(builder: (context) {
        Widget _result;

        if (_frequencyController?.loadingCurricularComponent ?? false) {
          _result = _buildLoadingWidget(size, screenHeight);
        }

        if (_frequencyController?.curricularComponent != null ?? false) {
          _result = _buildFrequencyExpandedPanel(index, size, screenHeight);
        }

        return _result ?? Text('erro ao obter dados');
      });

  _frequencyExpansionPanelCallback(int index, bool isExpanded) async {
    await _frequencyController.showCard(index);
    bool isExpanded = _frequencyController
        .frequency.componentesCurricularesDoAluno[index].isExpanded;

    if (isExpanded) {
      var _result = await _frequencyController.fetchCurricularComponent(
          anoLetivo,
          widget.student.codigoEscola,
          widget.student.codigoTurma.toString(),
          widget.student.codigoEol.toString(),
          _frequencyController.frequency.componentesCurricularesDoAluno[index]
              .codigoComponenteCurricular
              .toString());

      _frequencyController.frequency.componentesCurricularesDoAluno[index]
          .curricularComponent = _result;
    }

    setState(() {});
  }

  _frequencyExpandedPanel(index, size, screenHeight) => ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
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
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              color: Color(0xffDBDBDB),
              width: 1.0,
            ),
          )),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _frequencyContainerBodyObserver(index, size, screenHeight),
            ],
          ),
        ),
        isExpanded: _frequencyController
            .frequency.componentesCurricularesDoAluno[index].isExpanded,
      );

  _buildAlertEmptyFrequency(size, screenHeight) => CardAlert(
        title: "FREQUÊNCIA",
        icon: Icon(
          FontAwesomeIcons.calendarAlt,
          color: Color(0xffFFD037),
          size: screenHeight * 6,
        ),
        text:
            "Não foi encontrado nenhum dado de frequência para este estudante.",
      );

  _messageComponentCurricular(double screenHeight) => Container(
        padding: EdgeInsets.all(screenHeight * 1.5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffBDBECB), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(screenHeight * 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: AutoSizeText(
          "Apenas os componentes curriculares com registro de frequência por parte dos professores estão sendo apresentados.",
          minFontSize: 14,
          maxFontSize: 16,
          style: TextStyle(color: Colors.black),
        ),
      );

  _buildMainFrequencyContainer(size, screenHeight) {
    List _compList =
        _frequencyController.frequency.componentesCurricularesDoAluno;
    List<ExpansionPanel> _children =
        _compList.asMap().entries.map<ExpansionPanel>((entry) {
      return _frequencyExpandedPanel(entry.key, size, screenHeight);
    }).toList();

    return ExpansionPanelList(
      expansionCallback: _frequencyExpansionPanelCallback,
      children: _children,
    );
  }

  _buildEmptyContainer() => Container(
        height: 0,
        width: 0,
      );

  _globalFrequencyObserver(size, screenHeight) => Observer(builder: (context) {
        if (_frequencyController.loadingFrequency) {
          return _buildLoadingWidget(size, screenHeight);
        }

        if (_frequencyController.frequency != null) {
          return FrequencyGlobalCard(frequency: _frequencyController.frequency);
        }

        return _buildAlertEmptyFrequency(size, screenHeight);
      });

  _detailedFrequencyObserver(size, screenHeight) =>
      Observer(builder: (context) {
        if (_frequencyController.loadingFrequency) {
          return _buildLoadingWidget(size, screenHeight);
        }

        if (_frequencyController.frequency != null) {
          return _buildMainFrequencyContainer(size, screenHeight);
        }

        return _buildEmptyContainer();
      });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(screenHeight * 2.5),
      child: Column(
        children: [
          _messageComponentCurricular(screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          _globalFrequencyObserver(size, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          _detailedFrequencyObserver(size, screenHeight)
        ],
      ),
    );
  }
}
