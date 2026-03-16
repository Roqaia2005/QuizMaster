import 'package:flutter/material.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.questionImage,
    required this.questionText,
  });

  final String questionImage;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),

        color: Colors.white,

        child: Padding(
          padding: EdgeInsets.only(bottom: 36.h),
          child: Column(
            children: [
              Image.asset(questionImage),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(questionText, style: TextStyles.font16TitleBold),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
