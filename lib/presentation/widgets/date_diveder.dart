import 'package:flutter/material.dart';
import 'package:messenger_mozz/utils/colors.dart';

class DateDivider extends StatelessWidget {
  final String date;

  const DateDivider({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDivider(),
        const SizedBox(width: 10),
        _buildDateText(),
        const SizedBox(width: 10),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return const Expanded(
      child: Divider(
        color: AppColors.lightGrey,
        height: 2,
      ),
    );
  }

  Widget _buildDateText() {
    return Text(
      date,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
      ),
    );
  }
}
