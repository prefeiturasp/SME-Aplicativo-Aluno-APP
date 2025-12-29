import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controllers/index.dart';
import '../../dtos/recomendacao_aluno.dto.dart';
import '../../enumeradores/modalidade_tipo.dart';
import '../../repositories/boletim_aluno_repository.dart';
import '../../repositories/recomendacao_aluno_repository.dart';
import '../../repositories/relatorio_raa_repository.dart';
import '../../stores/estudante.store.dart';
import '../../ui/widgets/buttons/ea_deafult_button.widget.dart';
import '../../utils/mensagem_sistema.dart';
import '../widgets/cards/card_alert.dart';
import 'corpo_notas.dart';
import 'obs_body.dart';
import 'tile_item.dart';

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

  const Expansion({
    super.key,
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
  ExpansionState createState() => ExpansionState();
}

class ExpansionState extends State<Expansion> {
  final _estudanteNotasController = GetIt.I.get<EstudanteNotasController>();
  final _estudanteStore = GetIt.I.get<EstudanteStore>();

  final _estudanteController = GetIt.I.get<EstudanteController>();
  final _boletimRepositorio = BoletimAlunoRepository();
  final _relatorioRaarepositorio = RelatorioRaaRepository();
  final _repositorioRecomandacao = RecomendacaoAlunoRepository();
  DateTime? dateTime;
  List<String> _bimestresErros = [];
  late List<int> _bimestres = [];
  var recomendacaoAluno = RecomendacaoAlunoDto();
  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    _estudanteNotasController.limparNotas();
    _buscarRecomandacao();
    carregarNotas();
  }

  Future<void> carregarNotas() async {
    final response = await _estudanteController.obterBimestresDisponiveisParaVisualizacao(widget.codigoTurma);

    response.fold((e) => _bimestresErros = e, (b) => _bimestres = b);

    if (_bimestresErros.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _alertaErroObterBimestres();
      });
    }

    if (_bimestres.isNotEmpty) {
      _estudanteNotasController.obterNotasConceito(_bimestres, widget.codigoUe, widget.codigoTurma, widget.codigoAluno);
    } else {
      _estudanteNotasController.limparNotas();
    }
  }

  String? _buildNotesDescUm(index) {
    return _estudanteNotasController.listNotesUm != null ? _estudanteNotasController.listNotesUm![index].notaDescricao : '';
  }

  String? _buildNotesDescDois(index) {
    return _estudanteNotasController.listNotesDois != null ? _estudanteNotasController.listNotesDois![index].notaDescricao : '';
  }

  String? _buildNotesDescTres(index) {
    return _estudanteNotasController.listNotesTres != null ? _estudanteNotasController.listNotesTres![index].notaDescricao : '';
  }

  String? _buildNotesDescQuatro(index) {
    return _estudanteNotasController.listNotesQuatro != null ? _estudanteNotasController.listNotesQuatro![index].notaDescricao : '';
  }

  String? _buildNotesDescFinal(index) {
    return _estudanteNotasController.listNotesFinal != null ? _estudanteNotasController.listNotesFinal![index].notaDescricao : '';
  }

  String _obterNota(int index, int bimestre) {
    final notaConceito = _estudanteNotasController.componentesCurricularesNotasConceitos?[index].notasConceitos!.where((element) => element.bimestre == bimestre);
    final qtdRegistros = notaConceito?.length ?? 0;
    if (qtdRegistros > 0) {
      return notaConceito != null ? (notaConceito.first.conceitoId > 0 ? notaConceito.first.notaConceito : notaConceito.first.nota.toString()) : '-';
    }
    return '-';
  }

  Color _obterCor(int index, int bimestre) {
    final notaConceito = _estudanteNotasController.componentesCurricularesNotasConceitos?[index].notasConceitos!.where((element) => element.bimestre == bimestre);
    final qtdRegistros = notaConceito?.length ?? 0;
    if (qtdRegistros > 0) {
      return notaConceito != null ? HexColor(notaConceito.first.corDaNota.toString()) : const Color(0xFFD4D4D4);
    }
    return const Color(0xFFD4D4D4);
  }

  Widget _corpoNotasMontar(context, int index) {
    return CorpoNotas(
      groupSchool: widget.groupSchool,
      title: _estudanteNotasController.componentesCurricularesNotasConceitos?[index].componenteCurricularNome ?? '',
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

  Container _buildLoader(screenHeight) => Container(
    margin: EdgeInsets.all(screenHeight * 1.5),
    child: const GFLoader(type: GFLoaderType.square, loaderColorOne: Color(0xffDE9524), loaderColorTwo: Color(0xffC65D00), loaderColorThree: Color(0xffC65D00), size: GFSize.LARGE),
  );

  TileItem _montarNotasConceito(screenHeight) => TileItem(
    body: [
      Container(
        height: screenHeight * 50,
        margin: EdgeInsets.all(screenHeight * 1),
        child: Scrollbar(
          child: ListView.builder(itemCount: _estudanteNotasController.componentesCurricularesNotasConceitos?.length ?? 0, itemBuilder: _corpoNotasMontar),
        ),
      ),
    ],
    header: 'Notas e conceitos do estudante',
  );

  Future _modalInfo(double screenHeight, String msg) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(screenHeight * 8), topLeft: Radius.circular(screenHeight * 8)),
          color: Colors.white,
        ),
        height: screenHeight * 30,
        child: Column(
          children: [
            Container(
              width: screenHeight * 8,
              height: screenHeight * 1,
              margin: EdgeInsets.only(top: screenHeight * 2),
              decoration: BoxDecoration(color: const Color(0xffDADADA), borderRadius: BorderRadius.all(Radius.circular(screenHeight * 1))),
            ),
            SizedBox(height: screenHeight * 3),
            const AutoSizeText(
              'AVISO',
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            const Expanded(child: Divider()),
            Container(
              height: screenHeight * 20,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  AutoSizeText(msg, maxFontSize: 10, minFontSize: 8, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 8),
                  Flexible(
                    child: EADefaultButton(
                      text: MensagemSistema.labelBotaoEntendi,
                      iconColor: Colors.white,
                      btnColor: const Color(0xffffd037),
                      enabled: true,
                      styleAutoSize: const TextStyle(color: Color(0xffd06d12), fontWeight: FontWeight.w600),
                      onPress: () {
                        Navigator.of(context).pop();
                      },
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

  Future<void> _buscarRecomandacao() async {
    final busca = await _repositorioRecomandacao.obterRecomendacaoAluno(
      widget.codigoAluno,
      widget.codigoTurma,
      widget.anoLetivo,
      int.parse(widget.codigoModalidade),
      widget.semestre,
    );
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
  void ocultarButao() {
    EasyLoading.show(status: 'Aguarde....');
    setState(() {
      mostrarBotao = false;
    });
  }

  void exibirBotao() {
    EasyLoading.dismiss();
    setState(() {
      mostrarBotao = true;
    });
  }

  Widget _gerarPdf(double screenHeight, GlobalKey<ScaffoldState> scaffoldstate) {
    if (widget.codigoModalidade == ModalidadeTipo.eja || widget.codigoModalidade == ModalidadeTipo.medio || widget.codigoModalidade == ModalidadeTipo.fundamental) {
      return mostrarBotao
          ? EADefaultButton(
              btnColor: Colors.white,
              iconColor: const Color(0xffffd037),
              icon: FontAwesomeIcons.penToSquare,
              text: MensagemSistema.labelBotaoGerarPDF,
              styleAutoSize: const TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
              onPress: () async {
                ocultarButao();
                final solicitacao = await _solicitarBoletim();
                if (solicitacao) {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.avisoSolicitacaoBoletim);
                } else {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.avisoErroInterno);
                }
              },
            )
          : const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  Widget _botaoRaa(double screenHeight, GlobalKey<ScaffoldState> scaffoldstate) {
    if (widget.codigoModalidade == ModalidadeTipo.educacaoInfantil) {
      return mostrarBotao
          ? EADefaultButton(
              btnColor: Colors.white,
              iconColor: const Color(0xffffd037),
              icon: FontAwesomeIcons.penToSquare,
              text: MensagemSistema.labelBotaoGerarRelatorio,
              styleAutoSize: const TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
              onPress: () async {
                ocultarButao();
                final solicitacao = await _solicitarRelatorioRaa();
                if (solicitacao) {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.avisoSolicitacaoRaa);
                } else {
                  exibirBotao();
                  _modalInfo(screenHeight, MensagemSistema.avisoErroInterno);
                }
              },
            )
          : const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  TileItem _montarObs(screenHeight) => TileItem(
    body: [
      Container(
        height: screenHeight * 50,
        margin: EdgeInsets.all(screenHeight * 1),
        child: Scrollbar(
          child: ObsBody(
            current: true,
            recomendacoesAluno: recomendacaoAluno.recomendacoesAluno ?? recomendacaoAluno.mensagemAlerta,
            recomendacoesFamilia: recomendacaoAluno.recomendacoesFamilia ?? 'Sem recomendações à familía para exibir',
            title: 'Recomendações',
          ),
        ),
      ),
    ],
    header: 'Observações',
  );

  void _alertaErroObterBimestres() {
    final mensagem = _bimestresErros.join('\n');
    final snackBar = SnackBar(backgroundColor: Colors.red, duration: const Duration(seconds: 10), content: Text(mensagem.isNotEmpty ? mensagem : 'Erro ao carregar bimestres'));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Observer(
            builder: (context) {
              if (_estudanteNotasController.loading || _estudanteStore.carregando) {
                return _buildLoader(screenHeight);
              }

              if (widget.codigoModalidade != ModalidadeTipo.educacaoInfantil) {
                return Column(children: [_montarNotasConceito(screenHeight), _montarObs(screenHeight), const SizedBox(height: 10), _gerarPdf(screenHeight, widget.scaffoldState)]);
              }
              if (widget.codigoModalidade == ModalidadeTipo.educacaoInfantil) {
                return Column(
                  children: [
                    Text(
                      MensagemSistema.textoTelaSolicitacaoRaa,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    _botaoRaa(screenHeight, widget.scaffoldState),
                  ],
                );
              }
              return CardAlert(
                title: 'NOTAS',
                icon: Icon(FontAwesomeIcons.calendar, color: const Color(0xffFFD037), size: screenHeight * 6),
                text: 'Não foi encontrado nenhuma nota para este estudante.',
              );
            },
          ),
        ],
      ),
    );
  }
}
