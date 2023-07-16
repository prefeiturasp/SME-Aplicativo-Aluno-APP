import 'dart:convert';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/interfaces/repositories/iusuario.repository.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class UsuarioRepository extends IUsuarioRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<ResponseDTO> atualizar(String nomeMae, DateTime dataNascimento, String email, String telefone) async {
    var body = json.encode({
      'id': usuarioStore.usuario.id,
      'email': email,
      'dataNascimentoResponsavel': dataNascimento.toString(),
      'nomeMae': nomeMae,
      'celular': telefone
    });

    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/Usuario");
      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = UsuarioDataModel.fromJson(decodeJson);

        usuarioStore.atualizarDados(email, dataNascimento, nomeMae, telefone, user.data.ultimaAtualizacao);

        return ResponseDTO.fromJson(decodeJson);
      } else if (response.statusCode == 408) {
        return ResponseDTO(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        var decodeError = jsonDecode(response.body);
        var dataError = ResponseDTO.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log("[Atualizar Usuário] Erro de requisição " + stacktrace.toString());

      throw Exception(error);
    }
  }

  @override
  Future<UsuarioModel> obterDadosUsuario() async {
    try {
      var url = Uri.https("${AppConfigReader.getApiHost()}/Usuario/${usuarioStore.usuario.cpf}");
      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${usuarioStore.usuario.token}",
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var usuario = UsuarioModel.fromJson(decodeJson);
        return usuario;
      }

      throw Exception(response.statusCode);
    } catch (error, stacktrace) {
      log("[Atualizar Usuário] Erro de requisição " + stacktrace.toString());

      throw Exception(error);
    }
  }
}
