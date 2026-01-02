import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/outros_servicos/outro_servico.model.dart';
import '../../repositories/outros_servicos_repository.dart';
import '../widgets/appbar/app_bar_escola_aqui.dart';

class OutrosServicosLista extends StatefulWidget {
  const OutrosServicosLista({super.key});

  @override
  OutrosServicosListaState createState() => OutrosServicosListaState();
}

class OutrosServicosListaState extends State<OutrosServicosLista> {
  @override
  Widget build(BuildContext context) {
    final outroServicosRepository = OutrosServicosRepository();
    final List<OutroServicoModel> valorInicial = [];
    return Scaffold(
      appBar: const AppBarEscolaAqui(titulo: 'Outros Serviços'),
      body: FutureBuilder<List<OutroServicoModel>>(
        future: outroServicosRepository.obterTodosLinks(),
        initialData: valorInicial,
        builder: (context, AsyncSnapshot<List<OutroServicoModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar serviços: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum serviço disponível'),
            );
          }

          return GroupedListView<dynamic, String>(
            elements: snapshot.data!.toList(),
            groupBy: (servico) => servico.categoria,
            groupComparator: (value2, value1) => value1.compareTo(value2),
            itemComparator: (item2, item1) => item1.titulo.compareTo(item2.titulo),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (c, servico) {
              return Card(
                elevation: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: obterIcone(servico),
                  title: Text(
                    servico.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(servico.descricao),
                  onTap: () {
                    launchUrl(Uri.parse(servico.urlSite), mode: LaunchMode.externalApplication);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Image obterIcone(dynamic servico) {
    return Image.network(
      servico.icone,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/icone_erro.png');
      },
    );
  }
}
