import 'package:flutter/material.dart';
import 'package:messenger_mozz/presentation/widgets/bubble_message.dart';
import 'package:messenger_mozz/presentation/widgets/date_diveder.dart';
import 'package:messenger_mozz/presentation/widgets/grey_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          leadingWidth: 22,
          title: const ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Text("KA"),
              ),
              title: Text("Виктор Власов"),
              subtitle: Text("В сети"))),
      body: Column(
        children: [
          const Spacer(),
          DateDivider(date: "26.09"),
          BubbleMessage(
            message: 'Hello, how are you?',
            isSentByUser: true,
          ),
          BubbleMessage(
            message: 'I\'m doing well, thank you!',
            isSentByUser: false,
          ),
          DateDivider(date: "Today"),
          const Divider(),
          buildInputButtons()
        ],
      ),
    );
  }

  Widget buildInputButtons() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          GreyBox(
            child: SizedBox(width: 42, child: Icon(Icons.attach_file)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: GreyBox(
                child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: 'Сообщение',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            )),
          ),
          SizedBox(width: 8),
          GreyBox(
            child: SizedBox(width: 42, child: Icon(Icons.mic_sharp)),
          )
        ],
      ),
    );
  }
}
