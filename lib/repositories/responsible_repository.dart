import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/responsible_repository_interface.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/utils/app_config_reader.dart';

class ResponsibleRepository implements IResponsibleRepository {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  @override
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    // Autenticacao/usuario/responsavel?cpf=40861153871
    try {
      final response = await http.get(
        "${AppConfigReader.getApiHost()}/Autenticacao/usuario/responsavel?cpf=${usuarioStore.usuario.cpf}",
        headers: {
          "Authorization": "Bearer ${usuarioStore.usuario.token}",
          "Content-Type": "application/json"
        },
      );

      print(
          "Request: ${response.statusCode} - ${response.request} | ${response.body} ");

      if (response.statusCode == 200) {
        return response.body == "true" ? true : false;
      } else {
        return true;
      }
    } catch (error, stacktrace) {
      print("Erro ao verificar se resposável tem aluno: " +
          stacktrace.toString());
      return true;
    }
  }
}
