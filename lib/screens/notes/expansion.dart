import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/dtos/recomendacao_aluno.dto.dart';
import 'package:sme_app_aluno/enumeradores/modalidade_tipo.dart';
import 'package:sme_app_aluno/repositories/boletim_aluno_repository.dart';
import 'package:sme_app_aluno/repositories/recomendacao_aluno_repository.dart';
import 'package:sme_app_aluno/repositories/relatorio_raa_repository.dart';
import 'package:sme_app_aluno/screens/notes/corpo_notas.dart';
import 'package:sme_app_aluno/screens/notes/obs_body.dart';
import 'package:sme_app_aluno/screens/notes/tile_item.dart';
import 'package:sme_app_aluno/screens/widgets/cards/card_alert.dart';
import 'package:sme_app_aluno/utils/mensagem_sistema.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Expansion extends StatefulWidget {
  final String codigoUe;
  final String codigoDre;
  final int semestre;
  final int modelo;
  final String codigoTurma;
  final String codigoAluno;
  final String groupSchool;
  final String codigoModalidade;
  final int anoLetivo;
  final GlobalKey<ScaffoldState> scaffoldState;

  Expansion({
    required this.codigoUe,
    required this.codigoTurma,
    required this.codigoAluno,
    required this.groupSchool,
    required this.scaffoldState,
    required this.codigoDre,
    required this.semestre,
    required this.modelo,
    required this.anoLetivo,
    required this.codigoModalidade,
  });

  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  final _estudanteNotasController = GetIt.I.get<EstudanteNotasController>();
  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _boletimRepositorio = BoletimAlunoRepository();
  final _relatorioRaarepositorio = RelatorioRaaRepository();
  final _repositorioRecomandacao = RecomendacaoAlunoRepository();
  late final DateTime _dateTime;
  var recomendacaoAluno = RecomendacaoAlunoDto();
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _estudanteNotasController.limparNotas();
    _buscarRecomandacao();
  }

  carregarNotas() async {
    var bimestres = await _estudanteController.obterBimestresDisponiveisParaVisualizacao(widget.codigoTurma);
    if (bimestres != null) {
      _estudanteNotasController.obterNotasConceito(bimestres, widget.codigoUe, widget.codigoTurma, widget.codigoAluno);
    } else {
      _estudanteNotasController.limparNotas();
    }
  }

  _buildNotesDescUm(index) {
    return _estudanteNotasController.listNotesUm.isNotEmpty
        ? _estudanteNotasController.listNotesUm[index].notaDescricao
        : '';
  }

  _buildNotesDescDois(index) {
    return _estudanteNotasController.listNotesDois.isNotEmpty
        ? _estudanteNotasController.listNotesDois[index].notaDescricao
        : '';
  }

  _buildNotesDescTres(index) {
    return _estudanteNotasController.listNotesTres.isNotEmpty
        ? _estudanteNotasController.listNotesTres[index].notaDescricao
        : '';
  }

  _buildNotesDescQuatro(index) {
    return _estudanteNotasController.listNotesQuatro.isNotEmpty
        ? _estudanteNotasController.listNotesQuatro[index].notaDescricao
        : '';
  }

  _buildNotesDescFinal(index) {
    return _estudanteNotasController.listNotesFinal.isNotEmpty
        ? _estudanteNotasController.listNotesFinal[index].notaDescricao
        : '';
  }

  String _obterNota(int index, int bimestre) {
    var notaConceito = _estudanteNotasController.componentesCurricularesNotasConceitos[index].notasConceitos!
        .where((element) => element.bimestre == bimestre);
    var qtdRegistros = notaConceito.length;
    if (qtdRegistros > 0) {
      return notaConceito != null
          ? (notaConceito.first.conceitoId != null
              ? notaConceito.first.notaConceito
              : notaConceito.first.nota.toString())
          : "-";
    }
    return "-";
  }

  Color _obterCor(int index, int bimestre) {
    var notaConceito = _estudanteNotasController.componentesCurricularesNotasConceitos[index].notasConceitos!
        .where((element) => element.bimestre == bimestre);
    var qtdRegistros = notaConceito.length;
    if (qtdRegistros > 0) {
      return notaConceito != null ? HexColor(notaConceito.first.corDaNota.toString()) : Color(0xFFD4D4D4);
    }
    return Color(0xFFD4D4D4);
  }

  Widget _corpoNotasMontar(context, int index) {
    return CorpoNotas(
      groupSchool: widget.groupSchool,
      title: _estudanteNotasController.componentesCurricularesNotasConceitos[index].componenteCurricularNome,
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
                itemCount: _estudanteNotasController.componentesCurricularesNotasConceitos.length,
                itemBuilder: _corpoNotasMontar,
              ),
            ),
          ),
        ],
        header: "Notas e conceitos do estudante",
      );

  _modalInfo(double screenHeight, String msg) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenHeight * 8),
            topLeft: Radius.circular(screenHeight * 8),
          ),
          color: Colors.white,
        ),
        height: screenHeight * 30,
        child: Column(
          children: [
            Container(
              width: screenHeight * 8,
              height: screenHeight * 1,
              margin: EdgeInsets.only(top: screenHeight * 2),
              decoration: BoxDecoration(
                color: Color(0xffDADADA),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 1),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 3,
            ),
            AutoSizeText(
              "AVISO",
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Container(
              height: screenHeight * 20,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  AutoSizeText(
                    msg,
                    maxFontSize: 13,
                    minFontSize: 11,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xffd06d12),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          "ENTENDI",
                          maxFontSize: 13,
                          minFontSize: 11,
                          style: TextStyle(color: Color(0xffd06d12), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _solicitarBoletim() async {
    return await _boletimRepositorio.solicitarBoletim(
      dreCodigo: widget.codigoDre,
      ueCodigo: widget.codigoUe,
      semestre: widget.semestre,
      turmaCodigo: widget.codigoTurma,
      anoLetivo: widget.anoLetivo,
      modalidadeCodigo: int.parse(widget.codigoModalidade),
      modelo: widget.modelo,
      alunoCodigo: widget.codigoAluno,
    );
  }

  _buscarRecomandacao() async {
    var busca = await _repositorioRecomandacao.obterRecomendacaoAluno(
        widget.codigoAluno, widget.codigoTurma, widget.anoLetivo, int.parse(widget.codigoModalidade), widget.semestre);
    setState(() {
      recomendacaoAluno = busca;
    });
  }

  Future<bool> _solicitarRelatorioRaa() async {
    return await _relatorioRaarepositorio.solicitarRelatorioRaa(
      dreCodigo: widget.codigoDre,
      ueCodigo: widget.codigoUe,
      semestre: widget.semestre,
      turmaCodigo: widget.codigoTurma,
      anoLetivo: widget.anoLetivo,
      modalidadeCodigo: int.parse(widget.codigoModalidade),
      alunoCodigo: widget.codigoAluno,
    );
  }

  bool mostrarBotao = true;
  ocultarButao() {
    EasyLoading.show(status: 'Aguarde....');
    setState(() {
      mostrarBotao = false;
    });
  }

  exibirBotao() {
    EasyLoading.dismiss();
    setState(() {
      mostrarBotao = true;
    });
  }

  _gerarPdf(double screenHeight, GlobalKey<ScaffoldState> scaffoldstate) {
    if (widget.codigoModalidade == ModalidadeTipo.EJA ||
        widget.codigoModalidade == ModalidadeTipo.Medio ||
        widget.codigoModalidade == ModalidadeTipo.Fundamental) {
      return mostrarBotao
          ? ElevatedButton(
              onPressed: () async {
                ocultarButao();
                var solicitacao = await _solicitarBoletim();
                if (solicitacao) {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.AvisoSolicitacaoBoletim);
                } else {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.AvisoErroInterno);
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xffd06d12),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    MensagemSistema.LabelBotaoGerarPDF,
                    maxFontSize: 16,
                    minFontSize: 14,
                    style: TextStyle(color: Color(0xffd06d12), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: screenHeight * 3,
                  ),
                  Icon(
                    FontAwesomeIcons.penToSquare,
                    color: Color(0xffffd037),
                    size: screenHeight * 3,
                  )
                ],
              ),
            )
          : SizedBox();
    } else {
      return SizedBox();
    }
  }

  _botaoRaa(double screenHeight, GlobalKey<ScaffoldState> scaffoldstate) {
    if (widget.codigoModalidade == ModalidadeTipo.EducacaoInfantil) {
      return mostrarBotao
          ? ElevatedButton(
              onPressed: () async {
                ocultarButao();
                var solicitacao = await _solicitarRelatorioRaa();
                if (solicitacao) {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.AvisoSolicitacaoRaa);
                } else {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.AvisoErroInterno);
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xffd06d12),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    MensagemSistema.LabelBotaoGerarRelatorio,
                    maxFontSize: 16,
                    minFontSize: 14,
                    style: TextStyle(color: Color(0xffd06d12), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: screenHeight * 3,
                  ),
                  Icon(
                    FontAwesomeIcons.penToSquare,
                    color: Color(0xffffd037),
                    size: screenHeight * 3,
                  )
                ],
              ),
            )
          : SizedBox();
    } else {
      return SizedBox();
    }
  }

  _montarObs(screenHeight) => TileItem(
        body: [
          Container(
            height: screenHeight * 50,
            margin: EdgeInsets.all(screenHeight * 1),
            child: Scrollbar(
              child: ObsBody(
                current: true,
                recomendacoesAluno: recomendacaoAluno.recomendacoesAluno ?? recomendacaoAluno.mensagemAlerta,
                recomendacoesFamilia:
                    recomendacaoAluno.recomendacoesFamilia ?? "Sem recomendações à familía para exibir",
                title: "Recomendações",
              ),
            ),
          ),
        ],
        header: "Observações",
      );

  @override
  Widget build(BuildContext context) {
    carregarNotas();
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

            if (widget.codigoModalidade != ModalidadeTipo.EducacaoInfantil) {
              return Container(
                child: Column(
                  children: [
                    _montarNotasConceito(screenHeight),
                    _montarObs(screenHeight),
                    SizedBox(
                      height: 10,
                    ),
                    _gerarPdf(screenHeight, widget.scaffoldState),
                  ],
                ),
              );
            }
            if (widget.codigoModalidade == ModalidadeTipo.EducacaoInfantil) {
              return Container(
                child: Column(
                  children: [
                    Text(
                      MensagemSistema.TextoTelaSolicitacaoRaa,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _botaoRaa(screenHeight, widget.scaffoldState),
                  ],
                ),
              );
            }
            return CardAlert(
              title: "NOTAS",
              icon: Icon(
                FontAwesomeIcons.calendar,
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
