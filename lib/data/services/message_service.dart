import 'package:messenger_mozz/data/model/user_model.dart';

class MessageService {
  static List<Message> messages = [];

  static List<Message> getMessagesForUser(String userId) {
    return messages.where((message) => message.sender.id == userId).toList();
  }

  static void addMessage(Message message) {
    messages.add(message);
  }
}
