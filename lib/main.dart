import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_master/core/app_router.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/data/quiz_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final quizData = await QuizRepository.loadQuiz();
  runApp(MyApp(quizData: quizData));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.quizData});

  final QuizData? quizData;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        title: 'Quiz Master',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => AppRouter.generateRoute(
          settings,
          quizData ?? QuizData(categories: []),
        ),
      ),
    );
  }
}
