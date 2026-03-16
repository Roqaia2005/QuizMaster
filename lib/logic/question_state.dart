part of 'question_cubit.dart';

abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final int currentQuestionIndex;
  final int score;
  final int? selectedAnswerIndex;
  final bool isAnswerChecked;
  final int timeRemaining;
  final bool wasTimeout;

  QuestionLoaded({
    required this.currentQuestionIndex,
    required this.score,
    required this.timeRemaining,
    this.selectedAnswerIndex,
    this.isAnswerChecked = false,
    this.wasTimeout = false,
  });

  QuestionLoaded copyWith({
    int? currentQuestionIndex,
    int? score,
    int? timeRemaining,
    int? selectedAnswerIndex,
    bool? isAnswerChecked,
    bool clearSelection = false,
    bool? wasTimeout,
  }) {
    return QuestionLoaded(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      selectedAnswerIndex: clearSelection
          ? null
          : (selectedAnswerIndex ?? this.selectedAnswerIndex),
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      wasTimeout: wasTimeout ?? this.wasTimeout,
    );
  }
}

class QuizCompleted extends QuestionState {
  final int finalScore;
  final int totalQuestions;

  QuizCompleted({required this.finalScore, required this.totalQuestions});
}
