// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_configuration_bloc.dart';

enum QuizStateType {
  quizInitial,
  questionLoaded,
  answerCorrect,
  answerIncorrect,
  quizFinished
}

// class QuizConfigurationState extends Equatable {
//   final QuizStateType type;
//   const QuizConfigurationState({required this.type});

//   @override
//   List<Object?> get props => [type];

//   QuizConfigurationState copyWith(
//     QuizStateType questionLoaded, {
//     QuizStateType? type,
//   }) {
//     return QuizConfigurationState(
//       type: type ?? this.type,
//     );
//   }

//   factory QuizConfigurationState.initial() =>
//       const QuizConfigurationState(type: QuizStateType.quizInitial);
// }
class QuizConfigurationState extends Equatable {
  final QuizStateType type;
  final Question? currentQuestion;
  final int timer;

  const QuizConfigurationState(
      {required this.type, this.currentQuestion, this.timer = 30});

  @override
  List<Object?> get props => [type, currentQuestion, timer];

  QuizConfigurationState copyWith(
    QuizStateType questionLoaded, {
    QuizStateType? type,
    Question? currentQuestion,
    int? timer,
  }) {
    return QuizConfigurationState(
      type: type ?? this.type,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      timer: timer ?? this.timer,
    );
  }

  factory QuizConfigurationState.initial() =>
      const QuizConfigurationState(type: QuizStateType.quizInitial);
}
