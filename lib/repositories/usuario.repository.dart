import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../dtos/response.dto.dart';
import '../interfaces/repositories/iusuario.repository.dart';
import '../models/index.dart';
import '../services/api.service.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class UsuarioRepository extends IUsuarioRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final api = GetIt.I.get<ApiService>();
  @override
  Future<ResponseDTO> atualizar(String nomeMae, DateTime dataNascimento, String email, String telefone) async {
    final body = json.encode({
      'id': usuarioStore.usuario.id,
      'email': email,
      'dataNascimentoResponsavel': dataNascimento.toString(),
      'nomeMae': nomeMae,
      'celular': telefone
    });

    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Usuario');
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final user = UsuarioDataModel.fromJson(decodeJson);

        usuarioStore.atualizarDados(email, dataNascimento, nomeMae, telefone, user.data.ultimaAtualizacao);

        return ResponseDTO.fromJson(decodeJson);
      } else if (response.statusCode == 408) {
        return ResponseDTO(ok: false, erros: [AppConfigReader.getErrorMessageTimeOut()]);
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = ResponseDTO.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log('[Atualizar Usuário] Erro de requisição $stacktrace');

      throw Exception(error);
    }
  }

  @override
  Future<UsuarioModel> obterDadosUsuario() async {
    try {
      final response = await api.dio.get('/Usuario/${usuarioStore.usuario.cpf}');
      if (response.statusCode == 200) {
        final usuario = UsuarioModel.fromMap(response.data);
        return usuario;
      }
      return UsuarioModel.clear();
    } catch (error, stacktrace) {
      log('[Atualizar Usuário] Erro de requisição $stacktrace');
      return UsuarioModel.clear();
    }
  }
}
