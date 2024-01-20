import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_mozz/data/model/user_model.dart';
import 'package:messenger_mozz/utils/colors.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addMessage(
      String chatId, Map<String, dynamic> message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message);
  }

  static Stream<QuerySnapshot> getMessages(String userId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  static Future<Message?> getLastMessage(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      return Message(
        id: querySnapshot.docs.first.id,
        text: data['text'] as String,
        timestamp: data['timestamp'].toDate(),
        sender: User(
          id: data['senderId'] as String,
          name: 'Me',
          color: AppColors.getRandomBrightColor(),
        ),
      );
    } else {
      return null;
    }
  }
}
