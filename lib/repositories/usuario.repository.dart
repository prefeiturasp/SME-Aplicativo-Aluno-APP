import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';
import 'package:http/http.dart' as http;

import 'package:sme_app_aluno/dtos/response.dto.dart';
import 'package:sme_app_aluno/interfaces/repositories/iusuario.repository.dart';
import 'package:sme_app_aluno/models/index.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class UsuarioRepository extends IUsuarioRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<ResponseDTO> atualizar(String nomeMae, DateTime dataNascimento,
      String email, String telefone) async {
    var body = json.encode({
      'id': usuarioStore.usuario.id,
      'email': email,
      'dataNascimentoResponsavel': dataNascimento.toString(),
      'nomeMae': nomeMae,
      'celular': telefone
    });

    try {
      final response = await http.put(
        "${AppConfigReader.getApiHost()}/Usuario",
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var user = UsuarioDataModel.fromJson(decodeJson);

        usuarioStore.atualizarDados(email, dataNascimento, nomeMae, telefone,
            user.data.ultimaAtualizacao);

        return ResponseDTO.fromJson(decodeJson);
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
      GetIt.I.get<SentryClient>().captureException(exception: error);
      return null;
    }
  }

  @override
  Future<UsuarioModel> obterDadosUsuario() async {
    try {
      final response = await http.get(
          "${AppConfigReader.getApiHost()}/Usuario/${usuarioStore.usuario.cpf}",
          headers: {
            "Authorization": "Bearer ${usuarioStore.usuario.token}",
            "Content-Type": "application/json",
          });

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var usuario = UsuarioModel.fromJson(decodeJson);
        return usuario;
      }

      return null;
    } catch (error, stacktrace) {
      print("[Atualizar Usuário] Erro de requisição " + stacktrace.toString());
      GetIt.I.get<SentryClient>().captureException(exception: error);
      return null;
    }
  }
}
