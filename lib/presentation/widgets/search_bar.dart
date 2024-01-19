import 'package:flutter/material.dart';
import 'package:messenger_mozz/utils/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
