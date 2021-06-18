import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/interfaces/repositories/iusuario.repository.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class UsuarioRepository extends IUsuarioRepository {
  @override
  Future<ResponseDTO> atualizar(String nomeMae, DateTime dataNascimento,
      String email, String telefone, int id, String token) async {
    var body = json.encode({
      'id': id,
      'email': email,
      'dataNascimentoResponsavel': dataNascimento.toString(),
      'nomeMae': nomeMae,
      'celular': telefone
    });

    try {
      final response = await http.put(
        "${AppConfigReader.getApiHost()}/Usuario",
        headers: {
          "Authorization": "Bearer ${token}",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return ResponseDTO.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 408) {
        return ResponseDTO(
            ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = ResponseDTO.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      print("[Atualizar Usuário] Erro de requisição " + stacktrace.toString());
      return null;
    }
  }
}
