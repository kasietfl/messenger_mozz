import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_mozz/data/services/firestore_service.dart';
import 'package:messenger_mozz/data/services/message_service.dart';
import 'package:messenger_mozz/data/model/user_model.dart';
import 'package:messenger_mozz/presentation/widgets/bubble_message.dart';
import 'package:messenger_mozz/presentation/widgets/date_diveder.dart';
import 'package:messenger_mozz/presentation/widgets/grey_box.dart';
import 'package:messenger_mozz/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  List<Message> messages = [];

  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    messages = MessageService.getMessagesForUser(widget.user.id);
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      Message newMessage = Message(
        id: DateTime.now().toString(),
        text: text,
        timestamp: DateTime.now(),
        sender: User(
            id: widget.user.id,
            name: widget.user.name,
            color: widget.user.color),
      );

      setState(() {
        messages.add(newMessage);
        MessageService.addMessage(newMessage);
      });

      Map<String, dynamic> message = {
        'text': text,
        'timestamp': DateTime.now(),
        'senderId': widget.user.id,
      };

      FirestoreService.addMessage(widget.user.id, message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: buildAppBarTitle(),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService.getMessages(widget.user.id),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                List<DocumentSnapshot>? docs = snapshot.data?.docs;
                List<Message> messages = (docs ?? []).map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return Message(
                    id: doc.id,
                    text: data['text'] as String,
                    timestamp: data['timestamp'].toDate(),
                    sender: User(
                      id: data['senderId'] as String,
                      name: widget.user.name,
                      color: AppColors.getRandomBrightColor(),
                    ),
                  );
                }).toList();

                return ListView.builder(
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    int reversedIndex = messages.length - 1 - index;
                    bool showDateDivider = reversedIndex == 0 ||
                        !isSameDay(messages[reversedIndex].timestamp,
                            messages[reversedIndex - 1].timestamp);

                    return Column(
                      children: [
                        if (showDateDivider)
                          DateDivider(
                            date: formatDateTime(
                                messages[reversedIndex].timestamp),
                          ),
                        BubbleMessage(
                          message: messages[reversedIndex].text,
                          isSentByUser: messages[reversedIndex].sender.id ==
                              widget.user.id,
                          time: DateFormat("HH:mm")
                              .format(messages[reversedIndex].timestamp),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Divider(
            color: AppColors.lightGrey,
          ),
          buildInputButtons()
        ],
      ),
    );
  }

  Widget buildAppBarTitle() {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: widget.user.color,
          radius: 25,
          child: Text(
            widget.user.name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          widget.user.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: const Text("В сети"));
  }

  Widget buildInputButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const GreyBox(
            child: SizedBox(width: 42, child: Icon(Icons.attach_file)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GreyBox(
                child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: 'Сообщение',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            )),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _sendMessage(_messageController.text),
            child: const GreyBox(
              child: SizedBox(
                width: 42,
                child: Icon(Icons.send),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String formatDateTime(DateTime dateTime) {
    DateTime currentDate = DateTime.now();

    if (isSameDay(dateTime, currentDate)) {
      return "Сегодня";
    } else {
      return "${dateTime.day}.${dateTime.month}.${dateTime.year}";
    }
  }
}
