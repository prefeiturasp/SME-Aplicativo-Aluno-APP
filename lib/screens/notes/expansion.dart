import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sme_app_aluno/controllers/note/list_notes.controller.dart';
import 'package:sme_app_aluno/screens/notes/notes_body.dart';
import 'package:sme_app_aluno/screens/notes/obs_body.dart';
import 'package:sme_app_aluno/screens/notes/tile_item.dart';
import 'package:sme_app_aluno/screens/widgets/cards/card_alert.dart';

class Expansion extends StatefulWidget {
  final String codigoUe;
  final String codigoTurma;
  final String codigoAluno;
  final String groupSchool;

  Expansion(
      {this.codigoUe, this.codigoTurma, this.codigoAluno, this.groupSchool});
  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  ListNotesController _listNotesController;
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _loadingNotes();
  }

  _loadingNotes() async {
    _listNotesController = ListNotesController();
    if (widget.groupSchool != 'EJA') {
      _listNotesController.fetchNotes(_dateTime.year, 0, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 1, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 2, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 3, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 4, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
    } else {
      _listNotesController.fetchNotes(_dateTime.year, 0, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 1, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
      _listNotesController.fetchNotes(_dateTime.year, 2, widget.codigoUe,
          widget.codigoTurma, widget.codigoAluno);
    }
  }

  _buildNotesTitle(index) {
    return _listNotesController.listNotesUm != null &&
              _listNotesController.listNotesUm.isNotEmpty
          ? _listNotesController.listNotesUm[index].componenteCurricular
          : _listNotesController.listNotesDois != null &&
              _listNotesController.listNotesDois.isNotEmpty
              ? _listNotesController.listNotesDois[index].componenteCurricular
              : _listNotesController.listNotesTres != null &&
                    _listNotesController.listNotesTres.isNotEmpty
                  ? _listNotesController.listNotesTres[index].componenteCurricular
                  : _listNotesController.listNotesQuatro != null &&
                        _listNotesController.listNotesQuatro.isNotEmpty
                      ? _listNotesController.listNotesQuatro[index].componenteCurricular
                      : _listNotesController.listNotesFinal[index].componenteCurricular;
  }

  _buildNotesPrimeiroBimestre(index) {
    return _listNotesController.listNotesUm != null &&
            _listNotesController.listNotesUm.isNotEmpty
          ? _listNotesController.listNotesUm[index].nota
          : '-';
  }

  _buildNotesSegundoBimestre(index) {
    return  _listNotesController.listNotesDois != null &&
            _listNotesController.listNotesDois.isNotEmpty
          ? _listNotesController.listNotesDois[index].nota
          : '-';
  }

  _buildNotesTerceiroBimestre(index) {
    return _listNotesController.listNotesTres != null &&
            _listNotesController.listNotesTres.isNotEmpty
          ? _listNotesController.listNotesTres[index].nota
          : '-';
  }

  _buildNotesQuartoBimestre(index) {
    return _listNotesController.listNotesQuatro != null &&
            _listNotesController.listNotesQuatro.isNotEmpty
          ? _listNotesController.listNotesQuatro[index].nota
          : '-';
  }

  _buildNotesBimestreFinal(index) {
    return _listNotesController.listNotesFinal !=
                      null &&
                  _listNotesController
                      .listNotesFinal.isNotEmpty
              ? _listNotesController
                  .listNotesFinal[index].nota
              : '-';
  }

  _buildNotesCorUm(index) {
    return _listNotesController.listNotesUm !=
                  null &&
              _listNotesController
                  .listNotesUm.isNotEmpty
          ? HexColor(_listNotesController
              .listNotesUm[index].corNotaAluno)
          : Color(0xFFD4D4D4);
  }

  _buildNotesCorDois(index) {
    return _listNotesController.listNotesDois !=
                      null &&
                  _listNotesController
                      .listNotesDois.isNotEmpty
              ? HexColor(_listNotesController
                  .listNotesDois[index]
                  .corNotaAluno)
              : Color(0xFFD4D4D4);
  }

  _buildNotesCorTres(index) {
    return _listNotesController.listNotesTres !=
                      null &&
                  _listNotesController
                      .listNotesTres.isNotEmpty
              ? HexColor(_listNotesController
                  .listNotesTres[index]
                  .corNotaAluno)
              : Color(0xFFD4D4D4);
  }

  _buildNotesCorQuatro(index) {
    return _listNotesController.listNotesQuatro !=
                      null &&
                  _listNotesController
                      .listNotesQuatro.isNotEmpty
              ? HexColor(_listNotesController
                  .listNotesQuatro[index]
                  .corNotaAluno)
              : Color(0xFFD4D4D4);
  }

  _buildNotesCorFinal(index) {
    return _listNotesController.listNotesFinal !=
                      null &&
                  _listNotesController
                      .listNotesFinal.isNotEmpty
              ? HexColor(_listNotesController
                  .listNotesFinal[index]
                  .corNotaAluno)
              : Color(0xFFD4D4D4);
  }

  _buildNotesDescUm(index) {
    return _listNotesController.listNotesUm !=
                  null &&
              _listNotesController
                  .listNotesUm.isNotEmpty
          ? _listNotesController
              .listNotesUm[index].notaDescricao
          : '';
  }

  _buildNotesDescDois(index) {
    return _listNotesController.listNotesDois !=
                      null &&
                  _listNotesController
                      .listNotesDois.isNotEmpty
              ? _listNotesController
                  .listNotesDois[index]
                  .notaDescricao
              : '';
  }

  _buildNotesDescTres(index) {
    return _listNotesController.listNotesTres !=
                      null &&
                  _listNotesController
                      .listNotesTres.isNotEmpty
              ? _listNotesController
                  .listNotesTres[index]
                  .notaDescricao
              : '';
  }

  _buildNotesDescQuatro(index) {
    return _listNotesController.listNotesQuatro !=
                      null &&
                  _listNotesController
                      .listNotesQuatro.isNotEmpty
              ? _listNotesController
                  .listNotesQuatro[index]
                  .notaDescricao
              : '';
  }

  _buildNotesDescFinal(index) {
    return _listNotesController.listNotesFinal !=
                      null &&
                  _listNotesController
                      .listNotesFinal.isNotEmpty
              ? _listNotesController
                  .listNotesFinal[index]
                  .notaDescricao
              : '';
  }

  Widget _notesBodyBuilder(context, index) {
    return NotesBody(
      groupSchool: widget.groupSchool,
      title: _buildNotesTitle(index),
      bUm: _buildNotesPrimeiroBimestre(index),
      bDois: _buildNotesSegundoBimestre(index),
      bTres: _buildNotesTerceiroBimestre(index),
      bQuatro: _buildNotesQuartoBimestre(index),
      bFinal: _buildNotesBimestreFinal(index),
      corUm: _buildNotesCorUm(index),
      corDois: _buildNotesCorDois(index),
      corTres: _buildNotesCorTres(index),
      corQuatro: _buildNotesCorQuatro(index),
      corFinal: _buildNotesCorFinal(index),
      descUm: _buildNotesDescUm(index),
      descDois: _buildNotesDescDois(index),
      descTres: _buildNotesDescTres(index),
      descQuatro: _buildNotesDescQuatro(index),
      descFinal: _buildNotesDescFinal(index),
    );
  }

  _buildLoader(screenHeight) => Container(
    child: GFLoader(
      type: GFLoaderType.square,
      loaderColorOne: Color(0xffDE9524),
      loaderColorTwo: Color(0xffC65D00),
      loaderColorThree: Color(0xffC65D00),
      size: GFSize.LARGE,
    ),
    margin: EdgeInsets.all(screenHeight * 1.5),
  );

  _hasListNotes() => 
    (_listNotesController.listNotesUm != null && _listNotesController.listNotesUm.isNotEmpty) ||
    (_listNotesController.listNotesDois != null && _listNotesController.listNotesDois.isNotEmpty) ||
    (_listNotesController.listNotesTres != null && _listNotesController.listNotesTres.isNotEmpty) ||
    (_listNotesController.listNotesQuatro != null && _listNotesController.listNotesQuatro.isNotEmpty) ||
    (_listNotesController.listNotesFinal != null && _listNotesController.listNotesFinal.isNotEmpty);

  _buildNotesTileItem(screenHeight) => TileItem(
    body: [
      Container(
        height: screenHeight * 50,
        margin: EdgeInsets.all(screenHeight * 1),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: _listNotesController.tamanho,
            itemBuilder: _notesBodyBuilder
          )
        ),
      )
    ],
    header: "Notas e conceitos do estudante",
  );

  _buildObsTileItem(screenHeight) => TileItem(
    body: [
      Container(
          height: screenHeight * 50,
          margin: EdgeInsets.all(screenHeight * 1),
          child: Scrollbar(
              child: SingleChildScrollView(
            child: Column(
              children: [
                _listNotesController.bFinal != null
                    ? ObsBody(
                        recomendacoesAluno: _listNotesController
                                    .bFinal !=
                                null
                            ? _listNotesController
                                .bFinal.recomendacoesAluno
                            : 'Sem recomendações ao aluno para este bimestre.',
                        recomendacoesFamilia: _listNotesController
                                    .bFinal !=
                                null
                            ? _listNotesController
                                .bFinal.recomendacoesFamilia
                            : 'Sem recomendações à familía para este bimestre',
                        current:
                            _listNotesController.bFinal != null
                                ? true
                                : false,
                        title: 'Final',
                      )
                    : SizedBox.shrink(),
                _listNotesController.bQuatro != null
                    ? ObsBody(
                        recomendacoesAluno: _listNotesController
                                    .bQuatro !=
                                null
                            ? _listNotesController
                                .bQuatro.recomendacoesAluno
                            : 'Sem recomendações ao aluno para este bimestre.',
                        recomendacoesFamilia: _listNotesController
                                    .bQuatro !=
                                null
                            ? _listNotesController
                                .bQuatro.recomendacoesFamilia
                            : 'Sem recomendações à familía para este bimestre',
                        current: _listNotesController.bFinal ==
                                    null &&
                                _listNotesController.bQuatro !=
                                    null
                            ? true
                            : false,
                        title: '4º Bim.',
                      )
                    : SizedBox.shrink(),
                _listNotesController.bTres != null
                    ? ObsBody(
                        recomendacoesAluno: _listNotesController
                                    .bTres !=
                                null
                            ? _listNotesController
                                .bTres.recomendacoesAluno
                            : 'Sem recomendações ao aluno para este bimestre.',
                        recomendacoesFamilia: _listNotesController
                                    .bTres !=
                                null
                            ? _listNotesController
                                .bTres.recomendacoesFamilia
                            : 'Sem recomendações à familía para este bimestre',
                        current: _listNotesController.bQuatro ==
                                    null &&
                                _listNotesController.bTres !=
                                    null
                            ? true
                            : false,
                        title: '3º Bim.',
                      )
                    : SizedBox.shrink(),
                _listNotesController.bDois != null
                    ? ObsBody(
                        recomendacoesAluno: _listNotesController
                                    .bDois !=
                                null
                            ? _listNotesController
                                .bDois.recomendacoesAluno
                            : 'Sem recomendações ao aluno para este bimestre.',
                        recomendacoesFamilia: _listNotesController
                                    .bUm !=
                                null
                            ? _listNotesController
                                .bDois.recomendacoesFamilia
                            : 'Sem recomendações à familía para este bimestre',
                        current: widget.groupSchool != 'EJA'
                            ? (_listNotesController.bTres ==
                                        null &&
                                    _listNotesController
                                            .bDois !=
                                        null
                                ? true
                                : false)
                            : _listNotesController.bDois != null
                                ? true
                                : false,
                        title: '2º Bim.',
                      )
                    : SizedBox.shrink(),
                _listNotesController.bDois != null
                    ? ObsBody(
                        recomendacoesAluno: _listNotesController
                                    .bUm !=
                                null
                            ? _listNotesController
                                .bUm.recomendacoesAluno
                            : 'Sem recomendações ao aluno para este bimestre.',
                        recomendacoesFamilia: _listNotesController
                                    .bUm !=
                                null
                            ? _listNotesController
                                .bUm.recomendacoesFamilia
                            : 'Sem recomendações à familía para este bimestre',
                        current: _listNotesController.bDois ==
                                    null &&
                                _listNotesController.bUm != null
                            ? true
                            : false,
                        title: '1º Bim.',
                      )
                    : SizedBox.shrink(),
              ],
            ),
          )))
    ],
    header: "Observações",
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Observer(builder: (context) {
            if (_listNotesController.loading) {
              return _buildLoader(screenHeight);
            }

            if (_hasListNotes()) {
              return Container(
                child: Column(
                  children: [
                    _buildNotesTileItem(screenHeight),
                    _buildObsTileItem(screenHeight)
                  ]
                )
              );
            }

            return CardAlert(
              title: "NOTAS",
              icon: Icon(
                FontAwesomeIcons.calendarAlt,
                color: Color(0xffFFD037),
                size: screenHeight * 6,
              ),
              text: "Não foi encontrado nenhuma nota para este estudante.",
            );
          }),
        ],
      ),
    );
  }
}
