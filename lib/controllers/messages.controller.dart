import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/repositories/message_repository.dart';

part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  MessageRepository _messagesRepository;

  _MessagesControllerBase() {
    _messagesRepository = MessageRepository();
  }

  @observable
  List<Message> messages;

  @observable
  bool isLoading = false;

  @action
  Future<List<Message>> loadMessages(String token) async {
    this.isLoading = true;
    this.messages = await _messagesRepository.fetchMessages(token);
    this.isLoading = false;
    return this.messages;
  }
}
