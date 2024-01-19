import 'package:flutter/material.dart';
import 'package:messenger_mozz/data/model/user_model.dart';
import 'package:messenger_mozz/presentation/screens/chat_screen.dart';
import 'package:messenger_mozz/presentation/widgets/search_bar.dart';
import 'package:messenger_mozz/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Чаты",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        bottom: AppBar(
          title: const CustomSearchBar(),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildContactItem(index),
        itemCount: 4,
        separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: AppColors.lightGrey)),
      ),
    );
  }

  Widget buildContactItem(index) {
    User user = User(
        id: "$index",
        name: "User $index",
        color: AppColors.getRandomBrightColor());
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      user: user,
                    )));
      },
      leading: CircleAvatar(
        backgroundColor: user.color,
        radius: 25,
        child: Text(
          "${user.name[0]}${user.name.split(" ")[1]}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "Вы: Уже сделал?",
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGrey),
      ),
      trailing: Text("09:23"),
    );
  }
}
