import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../models/ue/data_ue.dart';
import '../services/api.service.dart';

class UERepository {
  final _api = GetIt.I.get<ApiService>();

  Future<DadosUE> obterPorCodigo(String codigoUe) async {
    try {
      final response = await _api.dio.get('/UnidadeEscolar/$codigoUe');
      if (response.statusCode == 200) {
        final ue = DadosUE.fromMap(response.data);
        return ue;
      } else {
        log('Erro ao obter dados');
        throw Exception(response.statusCode);
      }
    } catch (e) {
      log('$e');
      throw Exception(e);
    }
  }
}
