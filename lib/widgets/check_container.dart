import 'package:flutter/material.dart';
import 'package:quiz_master/core/text_styles.dart';

class CheckContainer extends StatelessWidget {
  const CheckContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.result,
    required this.color,
  });
  final String text;
  final IconData icon;
  final String result;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          Text(text, style: TextStyles.font14SubtitleSemiBold),
          Text(result, style: TextStyles.font18TitleRegular),
        ],
      ),
    );
  }
}
