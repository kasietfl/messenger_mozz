import 'package:flutter/material.dart';
import 'package:messenger_mozz/utils/colors.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final bool isSentByUser;

  const BubbleMessage({
    Key? key,
    required this.message,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSentByUser ? AppColors.green : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: TextStyle(color: AppColors.black),
        ),
      ),
    );
  }
}
