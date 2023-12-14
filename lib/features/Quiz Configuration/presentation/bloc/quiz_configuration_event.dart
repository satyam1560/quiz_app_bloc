part of 'quiz_configuration_bloc.dart';

abstract class QuizConfigurationEvent extends Equatable {
  const QuizConfigurationEvent();

  @override
  List<Object?> get props => [];
}

class StartQuiz extends QuizConfigurationEvent {
  final int amount;
  final int category;
  final String difficulty;
  final String type;

  const StartQuiz({
    required this.amount,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  @override
  List<Object?> get props => [amount, category, difficulty, type];
}

class AnswerQuestion extends QuizConfigurationEvent {
  final String answer;

  const AnswerQuestion(this.answer);
  @override
  List<Object?> get props => [answer];
}

class NextQuestion extends QuizConfigurationEvent {}

class TimeOut extends QuizConfigurationEvent {}
