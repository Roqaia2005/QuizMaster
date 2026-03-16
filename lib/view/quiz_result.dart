import 'package:flutter/material.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/routes.dart';
import 'package:quiz_master/core/spacing.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/core/extensions.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:quiz_master/widgets/result_image.dart';
import 'package:quiz_master/widgets/custom_button.dart';
import 'package:quiz_master/widgets/check_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({
    super.key,
    required this.score,
    required this.totalQuestions,
    this.category,
  });

  final int score;
  final int totalQuestions;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    final correctCount = score;
    final incorrectCount = totalQuestions - score;
    final percentage = (score / totalQuestions) * 100;
    final isSuccess = percentage >= 60;

    String resultMessage;
    if (percentage >= 90) {
      resultMessage = 'Outstanding! You\'re a Quiz Master!';
    } else if (percentage >= 70) {
      resultMessage = 'Great job! You\'re doing excellent!';
    } else if (percentage >= 60) {
      resultMessage = 'Good work! Keep practicing!';
    } else if (percentage >= 50) {
      resultMessage = 'Not bad! Try again to improve!';
    } else {
      resultMessage = 'Keep practicing! You can do better!';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quiz Result'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(24),

                ResultImage(isSuccess: isSuccess),
                verticalSpace(24),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'QUIZ COMPLETED',
                    style: TextStyles.font14PrimarySemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpace(16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Your score: ",
                        style: TextStyles.font32TitleBold,
                      ),
                      TextSpan(
                        text: "$score/$totalQuestions",
                        style: TextStyles.font30PrimarySemiBold,
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                Text(
                  resultMessage,
                  style: TextStyles.font18SubtitleBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CheckContainer(
                      text: "CORRECT",
                      icon: Icons.check_circle_outline,
                      result: correctCount.toString(),
                      color: Colors.green,
                    ),
                    CheckContainer(
                      text: "INCORRECT",
                      icon: Icons.cancel_outlined,
                      result: incorrectCount.toString(),
                      color: Colors.red,
                    ),
                  ],
                ),
                verticalSpace(30),

                CustomButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    if (category != null) {
                      context.pushReplacementNamed(
                        Routes.quiz,
                        arguments: category,
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.redo,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      Text(
                        " Retry Quiz",
                        style: TextStyles.font16WhiteSemiBold,
                      ),
                    ],
                  ),
                ),
                verticalSpace(15),

                CustomButton(
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(Routes.categories);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.house,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                      Text(
                        " Back to home",
                        style: TextStyles.font16PrimarySemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
