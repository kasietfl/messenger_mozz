import 'package:flutter/material.dart';
import 'package:messenger_mozz/utils/colors.dart';

class GreyBox extends StatelessWidget {
  final Widget child;
  const GreyBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child);
  }
}
