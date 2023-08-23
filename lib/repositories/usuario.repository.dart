import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';

import '../dtos/response.dto.dart';
import '../interfaces/repositories/iusuario.repository.dart';
import '../models/index.dart';
import '../services/api.service.dart';
import '../stores/index.dart';

class UsuarioRepository extends IUsuarioRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();
  final api = GetIt.I.get<ApiService>();
  @override
  Future<ResponseDTO> atualizar(String nomeMae, DateTime dataNascimento, String email, String telefone) async {
    final body = json.encode({
      'id': usuarioStore.usuario!.id,
      'email': email,
      'dataNascimentoResponsavel': dataNascimento.toString(),
      'nomeMae': nomeMae,
      'celular': telefone
    });
    try {
      final response = await api.dio.put('/Usuario', data: body);
      if (response.statusCode == 200) {
        final user = UsuarioDataModel.fromMap(response.data);
        usuarioStore.atualizarDados(email, dataNascimento, nomeMae, telefone, user.data.ultimaAtualizacao);
        return ResponseDTO.fromMap(response.data);
      } else {
        final dataError = ResponseDTO.fromMap(response.data);
        return dataError;
      }
    } catch (error, stacktrace) {
      log('[Atualizar Usuário] Erro de requisição $stacktrace');
      return ResponseDTO(ok: false, erros: ['Erro de requisição'], data: null);
    }
  }

  @override
  Future<UsuarioModel> obterDadosUsuario() async {
    try {
      final response = await api.dio.get('/Usuario/${usuarioStore.usuario!.cpf}');
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
