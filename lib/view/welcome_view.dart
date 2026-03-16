import 'package:flutter/material.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/routes.dart';
import 'package:quiz_master/core/spacing.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/core/extensions.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:quiz_master/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key, required this.quizData});
  final QuizData quizData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            children: [
              Image.asset('assets/images/welcome.png'),
              verticalSpace(24),

              Text("QuizMaster", style: TextStyles.font32TitleBold),
              verticalSpace(16),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  "Test your knowledge in different topics and climb the leaderboard",
                  style: TextStyles.font18SubtitleRegular,
                ),
              ),
              verticalSpace(24),
              CustomButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  context.pushNamed(Routes.quiz,arguments:quizData.categories.first);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Start Quiz", style: TextStyles.font18WhiteSemiBold),
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),
              verticalSpace(24),

              CustomButton(
                backgroundColor: AppColors.secondaryColor,
                onPressed: () {
                  context.pushNamed(Routes.categories);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose Category",
                      style: TextStyles.font18PrimarySemiBold,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
