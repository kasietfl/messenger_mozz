import 'package:flutter/material.dart';
import 'package:messenger_mozz/presentation/screens/chat_screen.dart';
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
        title: const Text("Чаты"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: buildSearchBar(),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => buildContactItem(),
              itemCount: 4,
              separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.search, color: AppColors.grey),
          ),
          SizedBox(width: 6),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Поиск',
                hintStyle: TextStyle(color: AppColors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactItem() {
    return ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      },
      leading: const CircleAvatar(
        radius: 25,
        child: Text("KA"),
      ),
      title: Text("Виктор Власов"),
      subtitle: Text("Вы: Уже сделал?"),
      trailing: Align(
          alignment: Alignment.topRight,
          widthFactor: 1,
          heightFactor: 1,
          child: Text("09:23")),
    );
  }
}
