import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/responsible_repository_interface.dart';
import 'package:sme_app_aluno/models/user/user.dart';
import 'package:sme_app_aluno/services/user.service.dart';
import 'package:sme_app_aluno/utils/api.dart';

class ResponsibleRepository implements IResponsibleRepository {
  final UserService _userService = UserService();

  @override
  Future<bool> checkIfResponsibleHasStudent(int userId) async {
    // Autenticacao/usuario/responsavel?cpf=40861153871
    User user = await _userService.find(userId);
    try {
      final response = await http.get(
        "${Api.HOST}/Autenticacao/usuario/responsavel?cpf=${user.cpf}",
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        return response.body == "true" ? true : false;
      } else {
        return true;
      }
    } catch (error, stacktrace) {
      print("Erro ao verificar se resposável tem aluno: " +
          stacktrace.toString());
      return null;
    }
  }
}
