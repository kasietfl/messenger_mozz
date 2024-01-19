import 'package:flutter/material.dart';
import 'package:messenger_mozz/utils/colors.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final String time;
  final bool isSentByUser;

  const BubbleMessage({
    Key? key,
    required this.message,
    required this.isSentByUser,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSentByUser ? AppColors.green : AppColors.lightGrey,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft:
                  isSentByUser ? Radius.circular(16) : Radius.circular(0),
              bottomRight:
                  isSentByUser ? Radius.circular(0) : Radius.circular(16)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 4),
            Text(
              time,
              style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
