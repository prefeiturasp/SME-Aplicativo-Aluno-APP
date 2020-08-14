import 'package:sme_app_aluno/models/message/message.dart';

abstract class IMessageRepository {
  Future<List<Message>> fetchMessages(String token, int codigoAluno);

  Future<bool> readMessage(int notificacaoId, int usuarioId, int codigoAlunoEol,
      bool mensagemVisualia);
}
