import 'package:flutter/cupertino.dart';

import 'outro_servico.model.dart';

class OutrosServicosCategoria {
  String categoria;
  List<OutroServicoModel> outrosServicos;

  OutrosServicosCategoria({
    @required this.categoria,
    @required this.outrosServicos,
  });
}
