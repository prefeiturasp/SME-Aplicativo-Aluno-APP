import 'package:flutter/material.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:sme_app_aluno/repositories/outros_servicos_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grouped_list/grouped_list.dart';

class OutrosServicosLista extends StatefulWidget {
  const OutrosServicosLista({Key key}) : super(key: key);

  @override
  _OutrosServicosListaState createState() => _OutrosServicosListaState();
}

class _OutrosServicosListaState extends State<OutrosServicosLista> {
  @override
  Widget build(BuildContext context) {
    var outroServicosRepository = OutrosServicosRepository();
    return Scaffold(
      appBar: AppBar(
        title: Text("Outros Serviços"),
      ),
      body: Container(
        child: FutureBuilder(
          future: outroServicosRepository.obterTodosLinks(),
          initialData: [],
          builder: (context, snapshot) {
            return GroupedListView<dynamic, String>(
              elements: snapshot.data.toList(),
              groupBy: (servico) => servico.categoria,
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1.titulo.compareTo(item2.titulo),
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
                  margin:
                      new EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Image.network(servico.icone),
                    title: Text(
                      servico.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(servico.descricao),
                    onTap: () {
                      launch(servico.urlSite);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
