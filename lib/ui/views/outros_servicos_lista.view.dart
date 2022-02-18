import 'package:flutter/material.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grouped_list/grouped_list.dart';

class OutrosServicosLista extends StatelessWidget {
  const OutrosServicosLista({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OutroServicoModel> outrosServico = [];
    outrosServico.add(OutroServicoModel(
      categoria: 'Alimentação',
      titulo: 'Prato Aberto',
      descricao:
          'Um Jeito fácil para todo mundo se nutir de informação sobre o que é servido na escola.',
      urlSite: 'https://pratoaberto.sme.prefeitura.sp.gov.br/',
      icone: 'assets/images/prato_aberto.png',
      prioridade: true,
    ));
    outrosServico.add(
      OutroServicoModel(
        categoria: 'Material e Uniforme',
        titulo: 'Material Escolar',
        descricao: 'Crédito para compra do material escolar no aplicativo.',
        urlSite: 'https://portalmaterialescolar.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/material_escolar.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        categoria: 'Material e Uniforme',
        titulo: 'Uniformes',
        descricao:
            'Use o crédito para comprar o uniforme escolar em um fornecedor cadastrado.',
        urlSite: 'https://portaldeuniformes.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/uniformes.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        categoria: 'Solicitações e Informações',
        titulo: 'Voltas às aulas',
        descricao: 'Veja todos os detalhes sobre a volta às aulas.',
        urlSite: 'https://educacao.sme.prefeitura.sp.gov.br/ano-letivo-2022/',
        icone: 'assets/images/voltas_aulas.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        categoria: 'Solicitações e Informações',
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
        categoria: 'Solicitações e Informações',
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
        categoria: 'Solicitações e Informações',
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
        categoria: 'Solicitações e Informações',
        titulo: 'Solicitação de vaga',
        descricao:
            'Preencha o formúlario online, para efetuar solicitações de vagas disponíveis.',
        urlSite: 'https://vaganacreche.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/solicitacao_vaga.png',
        prioridade: false,
      ),
    );
    List mapOutrosServico = [];

    for (var i = 0; i < outrosServico.length; i++) {
      mapOutrosServico.add(outrosServico[i].toJson());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Outros Serviços"),
      ),
      body: GroupedListView<dynamic, String>(
        elements: mapOutrosServico,
        groupBy: (servico) => servico['categoria'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['titulo'].compareTo(item2['titulo']),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            value,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, servico) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Image.asset(servico['icone']),
              title: Text(
                servico['titulo'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(servico['descricao']),
              onTap: () {
                launch(servico['urlSite']);
              },
            ),
          );
        },
      ),
    );
  }
}
