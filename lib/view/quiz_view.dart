import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/spacing.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/logic/question_cubit.dart';
import 'package:quiz_master/widgets/option.dart';
import 'package:quiz_master/core/extensions.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:quiz_master/widgets/custom_button.dart';
import 'package:quiz_master/widgets/question_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_master/core/routes.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => QuestionCubit()..startQuiz(category.questions),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text("QuizMaster", style: TextStyles.font18TitleBold),
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(FontAwesomeIcons.xmark, size: 18.sp),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocListener<QuestionCubit, QuestionState>(
              listener: (context, state) {
                // Show snackbar when timeout occurs
                if (state is QuestionLoaded && state.wasTimeout) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Time\'s up! Moving to next question...',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // Reset the timeout flag
                  context.read<QuestionCubit>().resetTimeoutFlag();
                }
              },
              child: BlocBuilder<QuestionCubit, QuestionState>(
                builder: (context, state) {
                /// QUIZ FINISHED - Navigate to result screen
                if (state is QuizCompleted) {
                  // Use WidgetsBinding to ensure navigation happens after build
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.pushReplacementNamed(
                      Routes.result,
                      arguments: {
                        'score': state.finalScore,
                        'totalQuestions': state.totalQuestions,
                        'category': category,
                      },
                    );
                  });
                  return const Center(child: CircularProgressIndicator());
                }

                /// QUIZ LOADED
                if (state is QuestionLoaded) {
                  final questionIndex = state.currentQuestionIndex;
                  final timeRemaining = state.timeRemaining;
                  final selectedAnswerIndex = state.selectedAnswerIndex;
                  final isAnswerChecked = state.isAnswerChecked;

                  final currentQuestion = category.questions[questionIndex];

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: SingleChildScrollView(
                      key: ValueKey(questionIndex),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          category.name.toUpperCase(),
                          style: TextStyles.font18PrimaryBold,
                        ),
                        verticalSpace(16),

                        /// QUESTION NUMBER + TIMER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Question ${questionIndex + 1}",
                                    style: TextStyles.font16TitleBold,
                                  ),
                                  TextSpan(
                                    text: "/${category.questions.length}",
                                    style: TextStyles.font14SubtitleSemiBold,
                                  ),
                                ],
                              ),
                            ),

                            /// TIMER
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 0.02.w,
                                ),
                                borderRadius: BorderRadius.circular(24.r),
                                color: AppColors.secondaryColor,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.clock,
                                    color: AppColors.primaryColor,
                                    size: 15.sp,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "00:${timeRemaining.toString().padLeft(2, '0')}",
                                      style: TextStyles.font14PrimarySemiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        verticalSpace(16),

                        /// PROGRESS BAR
                        LinearProgressIndicator(
                          value:
                              (questionIndex + 1) / category.questions.length,
                          backgroundColor: AppColors.secondaryColor,
                          color: AppColors.primaryColor,
                          minHeight: 10.h,
                          borderRadius: BorderRadius.circular(10.r),
                        ),

                        verticalSpace(24),

                        /// QUESTION CARD
                        QuestionCard(
                          questionImage: "assets/images/question.png",
                          questionText: currentQuestion.question,
                        ),

                        verticalSpace(16),

                        /// OPTIONS
                        ListView.builder(
                          itemCount: currentQuestion.options.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Option(
                              optionText: currentQuestion.options[index],
                              isSelected: selectedAnswerIndex == index,
                              isLocked: isAnswerChecked,
                              isCorrect:
                                  isAnswerChecked &&
                                  currentQuestion.options[index] ==
                                      currentQuestion.answer,
                              onTap: () {
                                context.read<QuestionCubit>().selectAnswer(
                                  index,
                                );
                              },
                            );
                          },
                        ),

                        verticalSpace(24),

                        /// NEXT BUTTON
                        CustomButton(
                          backgroundColor: AppColors.primaryColor,
                          onPressed: selectedAnswerIndex == null
                              ? null
                              : () {
                                  if (!isAnswerChecked) {
                                    context.read<QuestionCubit>().checkAnswer();
                                  } else {
                                    context
                                        .read<QuestionCubit>()
                                        .nextQuestion();
                                  }
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isAnswerChecked
                                    ? "Next Question"
                                    : "Check Answer",
                                style: TextStyles.font16WhiteSemiBold,
                              ),
                              Icon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                }

                /// LOADING STATE
                return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
