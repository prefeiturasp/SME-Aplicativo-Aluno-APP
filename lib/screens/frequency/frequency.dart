import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/dtos/componente_curricular.dto.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/box_frequency.dart';
import 'package:sme_app_aluno/screens/frequency/widgets/label_frequency.dart';
import 'package:sme_app_aluno/screens/widgets/cards/card_alert.dart';
import 'package:sme_app_aluno/screens/widgets/cards/frequency_global_card.dart';
import 'package:sme_app_aluno/stores/index.dart';

class Frequency extends StatefulWidget {
  final EstudanteModel student;

  Frequency({
    required this.student,
  });

  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  final _frequencyController = GetIt.I.get<EstudanteFrequenciaController>();
  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _usuarioStore = GetIt.I.get<UsuarioStore>();
  List<int> _bimestres = [];
  List<ComponenteCurricularDTO> _componentesCurriculares = [];
  final anoLetivo = new DateTime.now().year;

  @override
  void initState() {
    super.initState();
    obterFrequencias();
  }

  Future<void> obterFrequencias() async {
    _frequencyController.limpar();
    _bimestres =
        await _estudanteController.obterBimestresDisponiveisParaVisualizacao(widget.student.codigoTurma.toString());

    _componentesCurriculares = await _estudanteController.obterComponentesCurriculares(_bimestres,
        widget.student.codigoEscola, widget.student.codigoTurma.toString(), widget.student.codigoEol.toString());

    await _frequencyController.obterFrequenciaGlobal(
        widget.student.codigoTurma.toString(), widget.student.codigoEol.toString());

    setState(() {});
  }

  Widget _listBoxBimestre(
    ComponenteCurricularDTO data,
    bool aulas,
    bool faltas,
    bool compensacoes,
  ) {
    List<Widget> list = data.frequencias.map((frequency) {
      if (aulas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: new BoxFrequency(
            title: "${frequency.bimestre}º Bim.",
            idbox: "${frequency.totalAulas}",
            fail: false,
            ausencias: [],
          ),
        );
      }

      if (faltas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: "${frequency.bimestre}º Bim.",
            idbox: "${frequency.totalAusencias}",
            fail: true, ausencias: [],
            //ausencias: frequency.ausencias,
          ),
        );
      }

      if (compensacoes) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: "${frequency.bimestre}º Bim.",
            idbox: "${frequency.totalCompensacoes}",
            fail: false,
            ausencias: [],
          ),
        );
      }

      return Text("${frequency.bimestre}º Bim.");
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }

  Widget _rowFrequency(
    double screenHeight,
    String label,
    ComponenteCurricularDTO data,
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
    ComponenteCurricularDTO data,
    double screenHeight,
  ) {
    List<Widget> list = [];
    for (var i = 0; i < data.frequencias.length; i++) {
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "${data.frequencias[i].bimestre}º Bimestre",
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
                percent: data.frequencias[i].percentualFrequencia / 100,
                backgroundColor: Color(0xffEDEDED),
                progressColor: HexColor(data.frequencias[i].corDaFrequencia),
              ),
              AutoSizeText(
                "${data.frequencias[i].percentualFrequencia.toStringAsFixed(0)}%",
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
    var _comp = _componentesCurriculares[index];

    return Container(
      padding: EdgeInsets.all(screenHeight * 2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _comp.frequencias.length > 0
                ? _rowFrequency(
                    screenHeight,
                    "Quantidade de aulas",
                    _comp,
                    true,
                    false,
                    false,
                  )
                : Text("Não foram encontrados registros para este Componente Curricular"),
            _comp.frequencias.length > 0
                ? _rowFrequency(
                    screenHeight,
                    "Quantidade de ausências",
                    _comp,
                    false,
                    true,
                    false,
                  )
                : SizedBox(),
            _comp.frequencias.length > 0
                ? _rowFrequency(
                    screenHeight,
                    "Ausências compensadas",
                    _comp,
                    false,
                    false,
                    true,
                  )
                : SizedBox(),
            _comp.frequencias.length > 0 ? LabelFrequency(text: "Percentual de frequência") : SizedBox(),
            SizedBox(
              height: screenHeight * 2,
            ),
            _comp.frequencias.length > 0
                ? _listProgressBar(
                    _comp,
                    screenHeight,
                  )
                : SizedBox(),
            SizedBox(
              height: screenHeight * 2,
            ),
          ],
        ),
      ),
    );
  }

  _frequencyContainerBodyObserver(index, size, screenHeight) => Observer(builder: (context) {
        late final _result;

        if (_frequencyController.loadingCurricularComponent ?? false) {
          _result = _buildLoadingWidget(size, screenHeight);
        }

        _result = _buildFrequencyExpandedPanel(index, size, screenHeight);

        return _result ?? Text('erro ao obter dados');
      });

  _frequencyExpansionPanelCallback(int index, bool isExpanded) async {
    setState(() {
      _componentesCurriculares[index].expandido = _componentesCurriculares[index].expandido;
    });

    bool isExpanded = _componentesCurriculares[index].expandido;

    if (isExpanded) {
      var frequencias = await _frequencyController.fetchCurricularComponent(
          anoLetivo,
          widget.student.codigoEscola,
          widget.student.codigoTurma.toString(),
          widget.student.codigoEol.toString(),
          _componentesCurriculares[index].codigo.toString(),
          _bimestres);

      setState(() {
        _componentesCurriculares[index].frequencias = frequencias;
      });
    }
  }

  _frequencyExpandedPanel(index, size, screenHeight) => ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            width: MediaQuery.of(context).size.width,
            child: AutoSizeText(
              "${_componentesCurriculares[index].descricao}",
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
        isExpanded: _componentesCurriculares[index].expandido,
      );

  _buildAlertEmptyFrequency(size, screenHeight) => CardAlert(
        title: "FREQUÊNCIA",
        icon: Icon(
          FontAwesomeIcons.calendar,
          color: Color(0xffFFD037),
          size: screenHeight * 6,
        ),
        text: "Não foi encontrado nenhum dado de frequência para este estudante.",
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
    List _compList = _componentesCurriculares;
    List<ExpansionPanel> _children = _compList.asMap().entries.map<ExpansionPanel>((entry) {
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

        return FrequencyGlobalCard(frequencia: _frequencyController.frequencia!);
      });

  _detailedFrequencyObserver(size, screenHeight) => Observer(builder: (context) {
        if (_frequencyController.loadingFrequency) {
          return _buildLoadingWidget(size, screenHeight);
        }

        return _buildMainFrequencyContainer(size, screenHeight);
      });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
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
