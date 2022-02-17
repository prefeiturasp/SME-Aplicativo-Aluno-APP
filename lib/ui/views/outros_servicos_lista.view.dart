import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:collection/collection.dart";

class OutrosServicosLista extends StatelessWidget {
  const OutrosServicosLista({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OutroServicoModel> outrosServico = [];

    outrosServico.add(OutroServicoModel(
      cartegoria: 'Alimentação',
      titulo: 'Prato Aberto',
      descricao:
          'Um Jeito fácil para todo mundo se nutir de informação sobre o que é servido na escola',
      urlSite: 'https://pratoaberto.sme.prefeitura.sp.gov.br/',
      icone: 'assets/images/prato_aberto.png',
      prioridade: true,
    ));
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Material e Uniforme',
        titulo: 'Material Escolar',
        descricao: 'Crédito para compra do material escolar no aplicativo',
        urlSite: 'https://portalmaterialescolar.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/material_escolar.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Material e Uniforme',
        titulo: 'Uniformes',
        descricao:
            'Use o crédito para comprar o uniforme escolar em um fornecedor cadastrado',
        urlSite: 'https://portaldeuniformes.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/uniformes.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Voltas às aulas',
        descricao: 'Veja todos os detalhes sobre a volta às aulas',
        urlSite: 'https://educacao.sme.prefeitura.sp.gov.br/ano-letivo-2022/',
        icone: 'assets/images/voltas_aulas.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Escola aberta',
        descricao:
            'É possível consultar os dados de escolas ou gerais, de toda a Rede Municipal de Educação.',
        urlSite: 'https://escolaaberta.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/escola_aberta.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'NAAPA',
        descricao:
            'Conheça o trabalho do Núcleo de Apoio e Acompanhamento para Aprendizegem(NAAPA).',
        urlSite: 'https://turmadonaapa.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/naapa.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'SIC - Serviço de informações ao cidadão',
        descricao:
            'O SIC recebe e registra pedidos de acesso à informação feitos por cidadõas.',
        urlSite: 'http://esic.prefeitura.sp.gov.br/',
        icone: 'assets/images/sic.png',
        prioridade: false,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Solicitação de vaga',
        descricao:
            'Preencha o formúlario online, para efetuar solicitações de vagas disponíveis.',
        urlSite: 'https://vaganacreche.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/solicitacao_vaga.png',
        prioridade: false,
      ),
    );
    final agrupamentoPorCategoria =
        groupBy(outrosServico, (obj) => (obj as OutroServicoModel).cartegoria);

    final agrupamentoMap = agrupamentoPorCategoria.values.toList();
  
    pergarTipo(agrupamentoPorCategoria);
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Outros Serviços"),
      ),
      body: ListView.builder(
        itemCount: outrosServico.length,
        itemBuilder: (context, index) {
          return ListaGeralLiskOUtrosServicos(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            outroServicoMode: outrosServico[index],
          );
        },
      ),
    );
  }
}

pergarTipo(Map<String, List<OutroServicoModel>> agrupamentoPorCategoria) {}

class ListaGeralLiskOUtrosServicos extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final OutroServicoModel outroServicoMode;
  const ListaGeralLiskOUtrosServicos(
      {Key key,
      @required this.screenWidth,
      @required this.screenHeight,
      @required this.outroServicoMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffE5E5E5),
        width: MediaQuery.of(context).size.width,
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
                      bottom: BorderSide(color: Color(0xffC5C5C5), width: 0.5),
                    ),
                  ),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[],
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(right: screenHeight * 2.5),
                          //   child: ClipOval(
                          //     child: Image.asset(
                          //       outroServicoMode.icone,
                          //       width: screenHeight * 8,
                          //       height: screenHeight * 8,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: (screenWidth / 1.95),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: <Widget>[
                          //       AutoSizeText(
                          //         outroServicoMode.titulo,
                          //         maxFontSize: 16,
                          //         minFontSize: 14,
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //       AutoSizeText(
                          //         outroServicoMode.descricao,
                          //         maxFontSize: 16,
                          //         minFontSize: 14,
                          //         style: TextStyle(
                          //           color: Color(0xffC4C4C4),
                          //         ),
                          //         maxLines: 2,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    onTap: () => launch(outroServicoMode.urlSite),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
