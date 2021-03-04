import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/frequency_repository_interface.dart';
import 'package:sme_app_aluno/models/frequency/curricular_component.dart';
import 'package:sme_app_aluno/models/frequency/frequency.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class FrequencyRepository implements IFrequencyRepository {
  final UserService _userService = UserService();
  @override
  Future<Frequency> fetchFrequency(
    int anoLetivo,
    String codigoUe,
    String codigoTurma,
    String codigoAluno,
    int userId,
  ) async {
    User user = await _userService.find(userId);
    try {
      final response = await http.get(
          "${AppConfigReader.getApiHost()}/Aluno/frequencia?AnoLetivo=$anoLetivo&CodigoUe=$codigoUe&CodigoTurma=$codigoTurma&CodigoAluno=$codigoAluno",
          headers: {
            "Authorization": "Bearer ${user.token}",
            "Content-Type": "application/json",
          });

      if (response.statusCode == 200) {
        var frequencyResponse = jsonDecode(response.body);
        final frequency = Frequency.fromJson(frequencyResponse);
        return frequency;
      } else {
        print("Deu ruim");
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }

  @override
  Future<CurricularComponent> fetchCurricularComponent(
    anoLetivo,
    codigoUE,
    codigoTurma,
    codigoAluno,
    codigoComponenteCurricular,
  ) async {
    try {
      final response = await http.get(
          "${AppConfigReader.getApiHost()}/Aluno/frequencia/componente-curricular?AnoLetivo=$anoLetivo&CodigoUe=$codigoUE&CodigoTurma=$codigoTurma&CodigoAluno=$codigoAluno&CodigoComponenteCurricular=$codigoComponenteCurricular",
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        var curricularComponentResponse = jsonDecode(response.body);
        final curricularComponent =
            CurricularComponent.fromJson(curricularComponentResponse);
        return curricularComponent;
      } else {
        print("Deu ruim");
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
