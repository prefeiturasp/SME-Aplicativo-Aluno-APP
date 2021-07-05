import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/screens/notes/corpo_notas.dart';
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
  final _estudanteNotasController = GetIt.I.get<EstudanteNotasController>();
  final _estudanteController = GetIt.I.get<EstudanteController>();
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _estudanteNotasController.limparNotas();
    carregarNotas();
  }

  carregarNotas() async {
    var bimestres = await _estudanteController
        .obterBimestresDisponiveisParaVisualizacao(widget.codigoTurma);
    if (bimestres != null) {
      _estudanteNotasController.obterNotasConceito(
          bimestres, widget.codigoUe, widget.codigoTurma, widget.codigoAluno);
    }
  }

  _buildNotesDescUm(index) {
    return _estudanteNotasController.listNotesUm != null &&
            _estudanteNotasController.listNotesUm.isNotEmpty
        ? _estudanteNotasController.listNotesUm[index].notaDescricao
        : '';
  }

  _buildNotesDescDois(index) {
    return _estudanteNotasController.listNotesDois != null &&
            _estudanteNotasController.listNotesDois.isNotEmpty
        ? _estudanteNotasController.listNotesDois[index].notaDescricao
        : '';
  }

  _buildNotesDescTres(index) {
    return _estudanteNotasController.listNotesTres != null &&
            _estudanteNotasController.listNotesTres.isNotEmpty
        ? _estudanteNotasController.listNotesTres[index].notaDescricao
        : '';
  }

  _buildNotesDescQuatro(index) {
    return _estudanteNotasController.listNotesQuatro != null &&
            _estudanteNotasController.listNotesQuatro.isNotEmpty
        ? _estudanteNotasController.listNotesQuatro[index].notaDescricao
        : '';
  }

  _buildNotesDescFinal(index) {
    return _estudanteNotasController.listNotesFinal != null &&
            _estudanteNotasController.listNotesFinal.isNotEmpty
        ? _estudanteNotasController.listNotesFinal[index].notaDescricao
        : '';
  }

  String _obterNota(int index, int bimestre) {
    var notaConceito = _estudanteNotasController
        .componentesCurricularesNotasConceitos[index].notasConceitos
        .singleWhere((element) => element.bimestre == bimestre,
            orElse: () => null);
    return notaConceito != null
        ? (notaConceito.conceitoId != null
            ? notaConceito.notaConceito
            : notaConceito.nota.toString())
        : "-";
  }

  Color _obterCor(int index, int bimestre) {
    var notaConceito = _estudanteNotasController
        .componentesCurricularesNotasConceitos[index].notasConceitos
        .singleWhere((element) => element.bimestre == bimestre,
            orElse: () => null);
    return notaConceito != null
        ? HexColor(notaConceito.corDaNota.toString())
        : Color(0xFFD4D4D4);
  }

  Widget _corpoNotasMontar(context, index) {
    return CorpoNotas(
      groupSchool: widget.groupSchool,
      title: _estudanteNotasController
          .componentesCurricularesNotasConceitos[index]
          .componenteCurricularNome,
      bUm: _obterNota(index, 1),
      bDois: _obterNota(index, 2),
      bTres: _obterNota(index, 3),
      bQuatro: _obterNota(index, 4),
      bFinal: _obterNota(index, 0),
      corUm: _obterCor(index, 1),
      corDois: _obterCor(index, 2),
      corTres: _obterCor(index, 3),
      corQuatro: _obterCor(index, 4),
      corFinal: _obterCor(index, 0),
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

  _montarNotasConceito(screenHeight) => TileItem(
        body: [
          Container(
            height: screenHeight * 50,
            margin: EdgeInsets.all(screenHeight * 1),
            child: Scrollbar(
                child: ListView.builder(
                    itemCount: _estudanteNotasController
                        .componentesCurricularesNotasConceitos.length,
                    itemBuilder: _corpoNotasMontar)),
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
                    _estudanteNotasController.bFinal != null
                        ? ObsBody(
                            recomendacoesAluno: _estudanteNotasController
                                        .bFinal !=
                                    null
                                ? _estudanteNotasController
                                    .bFinal.recomendacoesAluno
                                : 'Sem recomendações ao aluno para este bimestre.',
                            recomendacoesFamilia: _estudanteNotasController
                                        .bFinal !=
                                    null
                                ? _estudanteNotasController
                                    .bFinal.recomendacoesFamilia
                                : 'Sem recomendações à familía para este bimestre',
                            current: _estudanteNotasController.bFinal != null
                                ? true
                                : false,
                            title: 'Final',
                          )
                        : SizedBox.shrink(),
                    _estudanteNotasController.bQuatro != null
                        ? ObsBody(
                            recomendacoesAluno: _estudanteNotasController
                                        .bQuatro !=
                                    null
                                ? _estudanteNotasController
                                    .bQuatro.recomendacoesAluno
                                : 'Sem recomendações ao aluno para este bimestre.',
                            recomendacoesFamilia: _estudanteNotasController
                                        .bQuatro !=
                                    null
                                ? _estudanteNotasController
                                    .bQuatro.recomendacoesFamilia
                                : 'Sem recomendações à familía para este bimestre',
                            current: _estudanteNotasController.bFinal == null &&
                                    _estudanteNotasController.bQuatro != null
                                ? true
                                : false,
                            title: '4º Bim.',
                          )
                        : SizedBox.shrink(),
                    _estudanteNotasController.bTres != null
                        ? ObsBody(
                            recomendacoesAluno: _estudanteNotasController
                                        .bTres !=
                                    null
                                ? _estudanteNotasController
                                    .bTres.recomendacoesAluno
                                : 'Sem recomendações ao aluno para este bimestre.',
                            recomendacoesFamilia: _estudanteNotasController
                                        .bTres !=
                                    null
                                ? _estudanteNotasController
                                    .bTres.recomendacoesFamilia
                                : 'Sem recomendações à familía para este bimestre',
                            current:
                                _estudanteNotasController.bQuatro == null &&
                                        _estudanteNotasController.bTres != null
                                    ? true
                                    : false,
                            title: '3º Bim.',
                          )
                        : SizedBox.shrink(),
                    _estudanteNotasController.bDois != null
                        ? ObsBody(
                            recomendacoesAluno: _estudanteNotasController
                                        .bDois !=
                                    null
                                ? _estudanteNotasController
                                    .bDois.recomendacoesAluno
                                : 'Sem recomendações ao aluno para este bimestre.',
                            recomendacoesFamilia: _estudanteNotasController
                                        .bUm !=
                                    null
                                ? _estudanteNotasController
                                    .bDois.recomendacoesFamilia
                                : 'Sem recomendações à familía para este bimestre',
                            current: widget.groupSchool != 'EJA'
                                ? (_estudanteNotasController.bTres == null &&
                                        _estudanteNotasController.bDois != null
                                    ? true
                                    : false)
                                : _estudanteNotasController.bDois != null
                                    ? true
                                    : false,
                            title: '2º Bim.',
                          )
                        : SizedBox.shrink(),
                    _estudanteNotasController.bDois != null
                        ? ObsBody(
                            recomendacoesAluno: _estudanteNotasController.bUm !=
                                    null
                                ? _estudanteNotasController
                                    .bUm.recomendacoesAluno
                                : 'Sem recomendações ao aluno para este bimestre.',
                            recomendacoesFamilia: _estudanteNotasController
                                        .bUm !=
                                    null
                                ? _estudanteNotasController
                                    .bUm.recomendacoesFamilia
                                : 'Sem recomendações à familía para este bimestre',
                            current: _estudanteNotasController.bDois == null &&
                                    _estudanteNotasController.bUm != null
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
            if (_estudanteNotasController.loading) {
              return _buildLoader(screenHeight);
            }

            if (_estudanteNotasController
                    .componentesCurricularesNotasConceitos !=
                null) {
              return Container(
                  child: Column(children: [
                _montarNotasConceito(screenHeight),
                _buildObsTileItem(screenHeight)
              ]));
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
