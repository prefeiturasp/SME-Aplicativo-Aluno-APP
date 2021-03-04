import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/interfaces/list_notes_repository_interface.dart';
import 'package:sme_app_aluno/models/note/list_notes.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class ListNotesRepository extends IListNotesRepository {
  @override
  Future<ListNotes> fetchListNotes(int anoLetivo, int bimestre, String codigoUe,
      String codigoTurma, String alunoCodigo) async {
    try {
      var response = await http.get(
          "${AppConfigReader.getApiHost()}/Aluno/notas?AnoLetivo=$anoLetivo&Bimestre=$bimestre&CodigoUe=$codigoUe&CodigoTurma=$codigoTurma&CodigoAluno=$alunoCodigo");
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        final listNotesResponse = ListNotes.fromJson(decodeJson);
        return listNotesResponse;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
