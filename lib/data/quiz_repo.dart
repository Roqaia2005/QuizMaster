import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quiz_master/data/question.dart';

class QuizRepository {
  static Future<QuizData> loadQuiz() async {
    final jsonString = await rootBundle.loadString('assets/data/quiz.json');
    return QuizData.fromJson(jsonDecode(jsonString));
  }
}
