import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../controllers/index.dart';
import '../../dtos/componente_curricular.dto.dart';
import '../../models/estudante.model.dart';
import '../../models/index.dart';
import '../widgets/cards/card_alert.dart';
import '../widgets/cards/frequency_global_card.dart';
import 'widgets/box_frequency.dart';
import 'widgets/label_frequency.dart';

class Frequency extends StatefulWidget {
  final EstudanteModel student;

  const Frequency({
    super.key,
    required this.student,
  });

  @override
  FrequencyState createState() => FrequencyState();
}

class FrequencyState extends State<Frequency> {
  final _frequencyController = GetIt.I.get<EstudanteFrequenciaController>();
  final _estudanteController = GetIt.I.get<EstudanteController>();
  List<int> _bimestres = [];
  List<ComponenteCurricularDTO> _componentesCurriculares = [];
  final anoLetivo = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    obterFrequencias();
  }

  Future<void> obterFrequencias() async {
    _frequencyController.limpar();
    _bimestres =
        await _estudanteController.obterBimestresDisponiveisParaVisualizacao(widget.student.codigoTurma.toString());

    _componentesCurriculares = await _estudanteController.obterComponentesCurriculares(
      _bimestres,
      widget.student.codigoEscola,
      widget.student.codigoTurma.toString(),
      widget.student.codigoEol.toString(),
    );

    await _frequencyController.obterFrequenciaGlobal(
      widget.student.codigoTurma.toString(),
      widget.student.codigoEol.toString(),
    );
  }

  Widget listBoxBimestre(
    ComponenteCurricularDTO data,
    bool aulas,
    bool faltas,
    bool compensacoes,
  ) {
    final List<Widget> list = data.frequencias.map((frequency) {
      if (aulas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: '${frequency.bimestre}º Bim.',
            idbox: '${frequency.totalAulas}',
            fail: false,
            ausencias: const [],
          ),
        );
      }

      if (faltas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: '${frequency.bimestre}º Bim.',
            idbox: '${frequency.totalAusencias}',
            fail: true, ausencias: const [],
            //ausencias: frequency.ausencias,
          ),
        );
      }

      if (compensacoes) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: '${frequency.bimestre}º Bim.',
            idbox: '${frequency.totalCompensacoes}',
            fail: false,
            ausencias: const [],
          ),
        );
      }

      return Text('${frequency.bimestre}º Bim.');
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }

  Widget rowFrequency(
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
        listBoxBimestre(
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

  Widget listProgressBar(
    ComponenteCurricularDTO data,
    double screenHeight,
  ) {
    final List<Widget> list = [];
    for (var i = 0; i < data.frequencias.length; i++) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${data.frequencias[i].bimestre}º Bimestre',
              maxFontSize: 13,
              minFontSize: 11,
              style: const TextStyle(
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
                  backgroundColor: const Color(0xffEDEDED),
                  progressColor: HexColor(data.frequencias[i].corDaFrequencia),
                ),
                AutoSizeText(
                  '${data.frequencias[i].percentualFrequencia.toStringAsFixed(0)}%',
                  maxFontSize: 13,
                  minFontSize: 11,
                  style: const TextStyle(
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
        ),
      );
    }
    return Column(children: list);
  }

  Container buildLoadingWidget(size, screenHeight) => Container(
        margin: EdgeInsets.all(screenHeight * 1.5),
        child: const GFLoader(
          type: GFLoaderType.square,
          loaderColorOne: Color(0xffDE9524),
          loaderColorTwo: Color(0xffC65D00),
          loaderColorThree: Color(0xffC65D00),
          size: GFSize.LARGE,
        ),
      );

  Container buildFrequencyExpandedPanel(index, size, screenHeight) {
    final comp = _componentesCurriculares[index];

    return Container(
      padding: EdgeInsets.all(screenHeight * 2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comp.frequencias.isNotEmpty
                ? rowFrequency(
                    screenHeight,
                    'Quantidade de aulas',
                    comp,
                    true,
                    false,
                    false,
                  )
                : const Text('Não foram encontrados registros para este Componente Curricular'),
            comp.frequencias.isNotEmpty
                ? rowFrequency(
                    screenHeight,
                    'Quantidade de ausências',
                    comp,
                    false,
                    true,
                    false,
                  )
                : const SizedBox(),
            comp.frequencias.isNotEmpty
                ? rowFrequency(
                    screenHeight,
                    'Ausências compensadas',
                    comp,
                    false,
                    false,
                    true,
                  )
                : const SizedBox(),
            comp.frequencias.isNotEmpty ? LabelFrequency(text: 'Percentual de frequência') : const SizedBox(),
            SizedBox(
              height: screenHeight * 2,
            ),
            comp.frequencias.isNotEmpty
                ? listProgressBar(
                    comp,
                    screenHeight,
                  )
                : const SizedBox(),
            SizedBox(
              height: screenHeight * 2,
            ),
          ],
        ),
      ),
    );
  }

  Observer frequencyContainerBodyObserver(index, size, screenHeight) => Observer(
        builder: (context) {
          late final Container result;

          if (_frequencyController.loadingCurricularComponent) {
            result = buildLoadingWidget(size, screenHeight);
          }

          result = buildFrequencyExpandedPanel(index, size, screenHeight);

          return result;
        },
      );

  Future<void> frequencyExpansionPanelCallback(int index, bool isExpanded) async {
    setState(() {
      _componentesCurriculares[index].expandido = _componentesCurriculares[index].expandido;
    });

    final bool isExpanded = _componentesCurriculares[index].expandido;

    if (isExpanded) {
      final frequencias = await _frequencyController.fetchCurricularComponent(
        anoLetivo,
        widget.student.codigoEscola,
        widget.student.codigoTurma.toString(),
        widget.student.codigoEol.toString(),
        _componentesCurriculares[index].codigo.toString(),
        _bimestres,
      );

      setState(() {
        _componentesCurriculares[index].frequencias = frequencias;
      });
    }
  }

  ExpansionPanel frequencyExpandedPanel(index, size, screenHeight) => ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            width: MediaQuery.of(context).size.width,
            child: AutoSizeText(
              '${_componentesCurriculares[index].descricao}',
              maxFontSize: 20,
              minFontSize: 18,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        body: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xffDBDBDB),
                width: 1.0,
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              frequencyContainerBodyObserver(index, size, screenHeight),
            ],
          ),
        ),
        isExpanded: _componentesCurriculares[index].expandido,
      );

  CardAlert buildAlertEmptyFrequency(size, screenHeight) => CardAlert(
        title: 'FREQUÊNCIA',
        icon: Icon(
          FontAwesomeIcons.calendar,
          color: const Color(0xffFFD037),
          size: screenHeight * 6,
        ),
        text: 'Não foi encontrado nenhum dado de frequência para este estudante.',
      );

  Container messageComponentCurricular(double screenHeight) => Container(
        padding: EdgeInsets.all(screenHeight * 1.5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffBDBECB), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(screenHeight * 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: const AutoSizeText(
          'Apenas os componentes curriculares com registro de frequência por parte dos professores estão sendo apresentados.',
          minFontSize: 14,
          maxFontSize: 16,
          style: TextStyle(color: Colors.black),
        ),
      );

  ExpansionPanelList buildMainFrequencyContainer(size, screenHeight) {
    final List compList = _componentesCurriculares;
    final List<ExpansionPanel> children = compList.asMap().entries.map<ExpansionPanel>((entry) {
      return frequencyExpandedPanel(entry.key, size, screenHeight);
    }).toList();

    return ExpansionPanelList(
      expansionCallback: frequencyExpansionPanelCallback,
      children: children,
    );
  }

  Observer globalFrequencyObserver(size, screenHeight) => Observer(
        builder: (context) {
          if (_frequencyController.loadingFrequency) {
            return buildLoadingWidget(size, screenHeight);
          }

          return FrequencyGlobalCard(frequencia: _frequencyController.frequencia);
        },
      );

  Observer detailedFrequencyObserver(size, screenHeight) => Observer(
        builder: (context) {
          if (_frequencyController.loadingFrequency) {
            return buildLoadingWidget(size, screenHeight);
          }

          return buildMainFrequencyContainer(size, screenHeight);
        },
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      padding: EdgeInsets.all(screenHeight * 2.5),
      child: Column(
        children: [
          messageComponentCurricular(screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          globalFrequencyObserver(size, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          detailedFrequencyObserver(size, screenHeight)
        ],
      ),
    );
  }
}
