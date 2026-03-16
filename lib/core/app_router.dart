import 'package:flutter/material.dart';
import 'package:quiz_master/core/routes.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/view/quiz_view.dart';
import 'package:quiz_master/view/quiz_result.dart';
import 'package:quiz_master/view/welcome_view.dart';
import 'package:quiz_master/view/categories_view.dart';

class AppRouter {
  static MaterialPageRoute? generateRoute(
    RouteSettings settings,
    QuizData quizData,
  ) {
    final categories = quizData.categories;
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(
          builder: (_) => WelcomeView(quizData: quizData),
        );
      case Routes.quiz:
        return MaterialPageRoute(
          builder: (_) => QuizView(category: settings.arguments as Category),
        );
      case Routes.categories:
        return MaterialPageRoute(
          builder: (_) => CategoriesView(categories: categories),
        );
      case Routes.result:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizResult(
            score: args?['score'] ?? 0,
            totalQuestions: args?['totalQuestions'] ?? 0,
            category: args?['category'] as Category?,
          ),
        );

      default:
        return null;
    }
  }
}
