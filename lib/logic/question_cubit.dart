import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/question.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());

  List<Question> _questions = [];
  Timer? _timer;
  final int _timePerQuestion =
      15; // Set the default time per question here in seconds

  /// Starts the quiz with a given list of questions.
  void startQuiz(List<Question> questions) {
    if (questions.isEmpty) return;
    _questions = questions;

    emit(
      QuestionLoaded(
        currentQuestionIndex: 0,
        score: 0,
        timeRemaining: _timePerQuestion,
        selectedAnswerIndex: null,
        isAnswerChecked: false,
        wasTimeout: false,
      ),
    );
    _startTimer();
  }

  /// Selects an answer for the current question.
  void selectAnswer(int index) {
    if (state is QuestionLoaded) {
      final currentState = state as QuestionLoaded;

      // Prevent changing the answer if it has already been checked
      if (currentState.isAnswerChecked) return;

      emit(currentState.copyWith(selectedAnswerIndex: index));
    }
  }

  /// Checks the currently selected answer and updates the score.
  void checkAnswer() {
    if (state is QuestionLoaded) {
      final currentState = state as QuestionLoaded;

      if (currentState.isAnswerChecked ||
          currentState.selectedAnswerIndex == null) {
        return;
      }

      _timer?.cancel();

      final currentQuestion = _questions[currentState.currentQuestionIndex];

      bool isCorrect =
          currentQuestion.options[currentState.selectedAnswerIndex!] ==
          currentQuestion.answer;

      emit(
        currentState.copyWith(
          isAnswerChecked: true,
          score: isCorrect ? currentState.score + 1 : currentState.score,
        ),
      );
    }
  }

  /// Advances to the next question or completes the quiz.
  void nextQuestion() {
    if (state is QuestionLoaded) {
      final currentState = state as QuestionLoaded;

      _timer?.cancel();

      int nextIndex = currentState.currentQuestionIndex + 1;

      if (nextIndex < _questions.length) {
        // Move to the next question
        emit(
          QuestionLoaded(
            currentQuestionIndex: nextIndex,
            score: currentState.score,
            timeRemaining: _timePerQuestion,
            wasTimeout: false,
          ),
        );
        _startTimer();
      } else {
        // Finish the quiz
        emit(
          QuizCompleted(
            finalScore: currentState.score,
            totalQuestions: _questions.length,
          ),
        );
      }
    }
  }

  /// Resets the timeout flag after showing snackbar
  void resetTimeoutFlag() {
    if (state is QuestionLoaded) {
      final currentState = state as QuestionLoaded;
      emit(currentState.copyWith(wasTimeout: false));
    }
  }

  /// Handles the countdown timer for the active question.
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is QuestionLoaded) {
        final currentState = state as QuestionLoaded;
        if (currentState.timeRemaining > 0) {
          emit(
            currentState.copyWith(
              timeRemaining: currentState.timeRemaining - 1,
            ),
          );
        } else {
          // Time is up - automatically move to next question
          _timer?.cancel();
          
          // If no answer was checked, move to next question (score stays same)
          if (!currentState.isAnswerChecked) {
            // Move to next question with timeout flag
            int nextIndex = currentState.currentQuestionIndex + 1;
            
            if (nextIndex < _questions.length) {
              // Move to the next question
              emit(
                QuestionLoaded(
                  currentQuestionIndex: nextIndex,
                  score: currentState.score, // Score doesn't increase (stays same)
                  timeRemaining: _timePerQuestion,
                  wasTimeout: true, // Flag to show snackbar
                ),
              );
              _startTimer();
            } else {
              // Finish the quiz
              emit(
                QuizCompleted(
                  finalScore: currentState.score,
                  totalQuestions: _questions.length,
                ),
              );
            }
          }
        }
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
