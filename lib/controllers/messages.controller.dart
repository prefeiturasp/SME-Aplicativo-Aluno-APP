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
  ObservableList<Message> messages;

  @observable
  Message recentMessage;

  @observable
  bool isLoading = false;

  @action
  loadMessages({String token}) async {
    isLoading = true;
    messages = ObservableList<Message>.of(
        await _messagesRepository.fetchMessages(token));
    isLoading = false;
  }
}
