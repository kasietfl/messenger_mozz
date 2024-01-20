import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_mozz/data/model/user_model.dart';
import 'package:messenger_mozz/data/services/firestore_service.dart';
import 'package:messenger_mozz/presentation/screens/chat_screen.dart';
import 'package:messenger_mozz/presentation/widgets/search_bar.dart';
import 'package:messenger_mozz/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> contacts = [
    User(id: "1", name: "Joe Doe", color: AppColors.getRandomBrightColor()),
    User(id: "2", name: "Mary Rich", color: AppColors.getRandomBrightColor()),
    User(
        id: "3", name: "Thor Odinson", color: AppColors.getRandomBrightColor()),
    User(id: "4", name: "Spider", color: AppColors.getRandomBrightColor()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Чаты",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: AppBar(
            title: const CustomSearchBar(),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: getUsersWithLastMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.separated(
              itemBuilder: (context, index) =>
                  buildContactItem(snapshot.data![index]),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: AppColors.lightGrey),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<User>> getUsersWithLastMessages() async {
    for (int i = 0; i < contacts.length; i++) {
      Message? lastMessage =
          await FirestoreService.getLastMessage(contacts[i].id);
      contacts[i].lastMessage = lastMessage;
    }

    return contacts;
  }

  Widget buildContactItem(User user) {
    return ListTile(
      onTap: () => navigateToDialog(user),
      leading: CircleAvatar(
        backgroundColor: user.color,
        radius: 25,
        child: Text(
          user.name[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        user.lastMessage != null ? user.lastMessage!.text : "Нет сообщений",
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGrey,
        ),
      ),
      trailing: user.lastMessage != null
          ? Text(DateFormat("HH:mm").format(user.lastMessage!.timestamp))
          : null,
    );
  }

  void navigateToDialog(User user) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          user: user,
        ),
      ),
    );

    if (result != null && result) {
      await getUsersWithLastMessages();
      setState(() {});
    }
  }
}
