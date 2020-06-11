import 'package:sme_app_aluno/models/message/message.dart';

abstract class IMessageRepository {
  Future<List<Message>> fetchMessages(String token);

  Future<bool> readMessage(
      int notificacaoId, String cpfUsuario, bool mensagemVisualia);
}
