import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../dtos/validacao_erro_dto.dart';
import '../interfaces/first_access_repository_interface.dart';
import '../models/change_email_and_phone/data_change_email_and_phone.dart';
import '../models/first_access/data.dart';
import '../models/user/user.dart' as UserModel;
import '../services/user.service.dart';
import '../stores/index.dart';
import '../utils/app_config_reader.dart';

class FirstAccessRepository implements IFirstAccessRepository {
  final UserService _userService = UserService();
  UsuarioStore usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<Data> changeNewPassword(int id, String password) async {
    final Map data0 = {
      'id': usuarioStore.usuario!.id,
      'novaSenha': password,
    };

    final body = json.encode(data0);
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/PrimeiroAcesso');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      final decodeJson = jsonDecode(response.body);
      final data = Data.fromJson(decodeJson);
      if (response.statusCode == 200) {
        await usuarioStore.atualizaPrimeiroAcesso(false);

        await _userService.update(
          UserModel.User(
            id: usuarioStore.usuario!.id,
            nome: usuarioStore.usuario!.nome,
            cpf: usuarioStore.usuario!.cpf,
            email: usuarioStore.usuario!.email,
            celular: usuarioStore.usuario!.celular,
            token: usuarioStore.usuario!.token,
            nomeMae: usuarioStore.usuario!.nomeMae,
            dataNascimento: usuarioStore.usuario!.dataNascimento,
            senha: usuarioStore.usuario!.senha,
            primeiroAcesso: false,
            atualizarDadosCadastrais: true,
          ),
        );

        return data;
      } else if (response.statusCode == 408) {
        return Data(
          ok: false,
          erros: [AppConfigReader.getErrorMessageTimeOut()],
          validacaoErros: ValidacaoErros(additionalProp1: [], additionalProp2: [], additionalProp3: []),
        );
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = Data.fromJson(decodeError);
        return dataError;
      }
    } catch (error, stacktrace) {
      log('[fetchFirstAccess] Erro de requisição $stacktrace');
      throw Exception(error);
    }
  }

  @override
  Future<DataChangeEmailAndPhone> changeEmailAndPhone(
    String email,
    String phone,
    int userId,
    bool changePassword,
  ) async {
    final Map data0 = {'id': userId, 'email': email, 'celular': phone, 'alterarSenha': changePassword};
    final body = json.encode(data0);
    try {
      final url = Uri.parse('${AppConfigReader.getApiHost()}/Autenticacao/AlterarEmailCelular');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${usuarioStore.usuario!.token}',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final data = DataChangeEmailAndPhone.fromJson(decodeJson);
        await _userService.update(
          UserModel.User(
            id: userId,
            nome: usuarioStore.usuario!.nome,
            cpf: usuarioStore.usuario!.cpf,
            email: email,
            celular: phone,
            token: data.token,
            primeiroAcesso: false,
            nomeMae: usuarioStore.usuario!.nomeMae,
            dataNascimento: usuarioStore.usuario!.dataNascimento,
            senha: usuarioStore.usuario!.senha,
            atualizarDadosCadastrais: false,
          ),
        );
        return data;
      } else {
        final decodeError = jsonDecode(response.body);
        final dataError = DataChangeEmailAndPhone.fromJson(decodeError);
        throw Exception(dataError);
      }
    } catch (error, stacktrace) {
      log('[changeEmailAndPhone] Erro de requisição $stacktrace');
      return DataChangeEmailAndPhone();
    }
  }
}
