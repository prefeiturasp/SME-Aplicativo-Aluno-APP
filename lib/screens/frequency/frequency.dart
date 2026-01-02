import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartz/dartz.dart' show Either;
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
import '../../stores/estudante.store.dart';
import 'widgets/box_frequency.dart';
import 'widgets/label_frequency.dart';
import '../widgets/cards/card_alert.dart';
import '../widgets/cards/frequency_global_card.dart';

class Frequency extends StatefulWidget {
  final EstudanteModel? student;

  const Frequency({super.key, required this.student});

  @override
  FrequencyState createState() => FrequencyState();
}

class FrequencyState extends State<Frequency> {
  final _frequencyController = GetIt.I.get<EstudanteFrequenciaController>();
  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();
  List<int>? _bimestres;
  List<String> _bimestresErros = [];
  List<ComponenteCurricularDTO>? _componentesCurriculares;
  final anoLetivo = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    obterFrequencias();
  }

  Future<void> obterFrequencias() async {
    _frequencyController.limpar();
    final Either<List<String>, List<int>> resultadoBimestres = await _estudanteController.obterBimestresDisponiveisParaVisualizacao(widget.student!.codigoTurma.toString());

    resultadoBimestres.fold((e) => _bimestresErros = e, (b) => _bimestres = b);

    if (_bimestresErros.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _alertaErroObterBimestres();
      });
    }

    if (_bimestres != null) {
      if (_bimestres!.isNotEmpty) {
        _componentesCurriculares = await _estudanteController.obterComponentesCurriculares(
          _bimestres!,
          widget.student!.codigoEscola,
          widget.student!.codigoTurma.toString(),
          widget.student!.codigoEol.toString(),
        );

        await _frequencyController.obterFrequenciaGlobal(widget.student!.codigoTurma.toString(), widget.student!.codigoEol.toString());
      }
    }

    setState(() {});
  }

  void _alertaErroObterBimestres() {
    final mensagem = _bimestresErros.join('\n');
    final snackBar = SnackBar(backgroundColor: Colors.red, duration: const Duration(seconds: 10), content: Text(mensagem.isNotEmpty ? mensagem : 'Erro ao carregar bimestres'));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _listBoxBimestre(ComponenteCurricularDTO data, bool aulas, bool faltas, bool compensacoes) {
    final List<Widget> list = data.frequencias.map((frequency) {
      if (aulas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(title: '${frequency.bimestre}º Bim.', idbox: '${frequency.totalAulas}', fail: false),
        );
      }

      if (faltas) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(
            title: '${frequency.bimestre}º Bim.',
            idbox: '${frequency.totalAusencias}',
            fail: true,
            //ausencias: frequency.ausencias,
          ),
        );
      }

      if (compensacoes) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: BoxFrequency(title: '${frequency.bimestre}º Bim.', idbox: '${frequency.totalCompensacoes}', fail: false),
        );
      }

      return Text('${frequency.bimestre}º Bim.');
    }).toList();

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: list);
  }

  Widget _rowFrequency(double screenHeight, String label, ComponenteCurricularDTO data, bool aulas, bool faltas, bool compensacoes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFrequency(text: label),
        SizedBox(height: screenHeight * 2),
        _listBoxBimestre(data, aulas, faltas, compensacoes),
        SizedBox(height: screenHeight * 2),
      ],
    );
  }

  Widget _listProgressBar(ComponenteCurricularDTO data, double screenHeight) {
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
              style: const TextStyle(color: Color(0xff757575), fontWeight: FontWeight.w400),
            ),
            SizedBox(height: screenHeight * 1),
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
                  style: const TextStyle(color: Color(0xff757575), fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 2.5),
          ],
        ),
      );
    }
    return Column(children: list);
  }

  Container _buildLoadingWidget(dynamic size, screenHeight) => Container(
    margin: EdgeInsets.all(screenHeight * 1.5),
    child: const GFLoader(type: GFLoaderType.square, loaderColorOne: Color(0xffDE9524), loaderColorTwo: Color(0xffC65D00), loaderColorThree: Color(0xffC65D00), size: GFSize.LARGE),
  );

  Container _buildFrequencyExpandedPanel(dynamic index, size, screenHeight) {
    final comp = _componentesCurriculares![index];

    return Container(
      padding: EdgeInsets.all(screenHeight * 2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comp.frequencias.isNotEmpty
                ? _rowFrequency(screenHeight, 'Quantidade de aulas', comp, true, false, false)
                : const Text('Não foram encontrados registros para este Componente Curricular'),
            comp.frequencias.isNotEmpty ? _rowFrequency(screenHeight, 'Quantidade de ausências', comp, false, true, false) : const SizedBox(),
            comp.frequencias.isNotEmpty ? _rowFrequency(screenHeight, 'Ausências compensadas', comp, false, false, true) : const SizedBox(),
            comp.frequencias.isNotEmpty ? const LabelFrequency(text: 'Percentual de frequência') : const SizedBox(),
            SizedBox(height: screenHeight * 2),
            comp.frequencias.isNotEmpty ? _listProgressBar(comp, screenHeight) : const SizedBox(),
            SizedBox(height: screenHeight * 2),
          ],
        ),
      ),
    );
  }

  Observer _frequencyContainerBodyObserver(dynamic index,dynamic  size,dynamic  screenHeight) => Observer(
    builder: (context) {
      Widget? result;

      if (_frequencyController.loadingCurricularComponent || _estudanteStore.carregando) {
        result = _buildLoadingWidget(size, screenHeight);
      }

      result = _buildFrequencyExpandedPanel(index, size, screenHeight);

      return result;
    },
  );

  Future<void> _frequencyExpansionPanelCallback(int index, bool isExpanded) async {
    setState(() {
      _componentesCurriculares![index].expandido = !_componentesCurriculares![index].expandido;
    });

    final bool isExpanded = _componentesCurriculares![index].expandido;

    if (isExpanded) {
      final frequencias = await _frequencyController.fetchCurricularComponent(
        anoLetivo,
        widget.student!.codigoEscola,
        widget.student!.codigoTurma.toString(),
        widget.student!.codigoEol.toString(),
        _componentesCurriculares![index].codigo.toString(),
        (_bimestres as List<int>),
      );

      setState(() {
        _componentesCurriculares![index].frequencias = frequencias;
      });
    }
  }

  ExpansionPanel _frequencyExpandedPanel(dynamic index, dynamic size, dynamic screenHeight) => ExpansionPanel(
    headerBuilder: (BuildContext context, bool isExpanded) {
      return Container(
        padding: EdgeInsets.all(screenHeight * 2.5),
        width: MediaQuery.of(context).size.width,
        child: AutoSizeText(
          '${_componentesCurriculares![index].descricao}',
          maxFontSize: 20,
          minFontSize: 18,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      );
    },
    body: Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xffDBDBDB), width: 1.0)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [_frequencyContainerBodyObserver(index, size, screenHeight)]),
    ),
    isExpanded: _componentesCurriculares![index].expandido,
  );

  CardAlert _buildAlertEmptyFrequency(dynamic size, screenHeight) => CardAlert(
    title: 'FREQUÊNCIA',
    icon: Icon(FontAwesomeIcons.calendarDays, color: const Color(0xffFFD037), size: screenHeight * 6),
    text: 'Não foi encontrado nenhum dado de frequência para este estudante.',
  );

  Container _messageComponentCurricular(double screenHeight) => Container(
    padding: EdgeInsets.all(screenHeight * 1.5),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xffBDBECB), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(screenHeight * 1)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.6),
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

  ExpansionPanelList _buildMainFrequencyContainer(dynamic size, screenHeight) {
    final List compList = _componentesCurriculares!;
    final List<ExpansionPanel> children = compList.asMap().entries.map<ExpansionPanel>((entry) => _frequencyExpandedPanel(entry.key, size, screenHeight)).toList();

    return ExpansionPanelList(expansionCallback: _frequencyExpansionPanelCallback, children: children);
  }

  SizedBox _buildEmptyContainer() => const SizedBox(height: 0, width: 0);

  Observer _globalFrequencyObserver(dynamic size, screenHeight) => Observer(
    builder: (context) {
      if (_frequencyController.loadingFrequency) {
        return _buildLoadingWidget(size, screenHeight);
      }
      if (_frequencyController.frequencia != null) {
        return FrequencyGlobalCard(frequencia: _frequencyController.frequencia);
      }

      return _buildAlertEmptyFrequency(size, screenHeight);
    },
  );

  Observer _detailedFrequencyObserver(dynamic size, screenHeight) => Observer(
    builder: (context) {
      if (_frequencyController.loadingFrequency) {
        return _buildLoadingWidget(size, screenHeight);
      }

      if (_componentesCurriculares != null) {
        return _buildMainFrequencyContainer(size, screenHeight);
      }

      return _buildEmptyContainer();
    },
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(screenHeight * 2.5),
      child: Column(
        children: [
          _messageComponentCurricular(screenHeight),
          SizedBox(height: screenHeight * 2.5),
          _globalFrequencyObserver(size, screenHeight),
          SizedBox(height: screenHeight * 2.5),
          _detailedFrequencyObserver(size, screenHeight),
        ],
      ),
    );
  }
}
