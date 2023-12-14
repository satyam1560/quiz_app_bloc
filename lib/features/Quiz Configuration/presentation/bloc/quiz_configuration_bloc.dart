import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/custimize_quiz_repo.dart';
import '../../data/models/question_model.dart';

part 'quiz_configuration_event.dart';
part 'quiz_configuration_state.dart';

// class QuizConfigurationBloc
//     extends Bloc<QuizConfigurationEvent, QuizConfigurationState> {
//   final CustomizeQuizRepo quizRepo;
//   late List<Question> questions;
//   int currentQuestionIndex = 0;
//   Timer? timer;
//   String? selectedAnswer;
//   QuizConfigurationBloc(this.quizRepo)
//       : currentQuestionIndex = 0,
//         super(QuizConfigurationState.initial()) {
//     on<StartQuiz>((event, emit) async {
//       questions = await quizRepo.fetchQuiz(
//         amount: event.amount,
//         category: event.category,
//         difficulty: event.difficulty,
//         type: event.type,
//       );

//       print('question $questions');
//       emit(state.copyWith(QuizStateType.questionLoaded,
//           currentQuestion: questions[currentQuestionIndex]));
//       startTimer();
//     });
//     on<AnswerQuestion>((event, emit) {
//       timer?.cancel();
//       if (questions[currentQuestionIndex].correctAnswer == selectedAnswer) {
//         emit(state.copyWith(QuizStateType.answerCorrect));
//       } else {
//         emit(state.copyWith(QuizStateType.answerIncorrect));
//       }
//       add(NextQuestion());
//     });

//     on<NextQuestion>((event, emit) {
//       if (++currentQuestionIndex < questions.length) {
//         emit(state.copyWith(QuizStateType.questionLoaded,
//             currentQuestion: questions[currentQuestionIndex]));
//         startTimer();
//       } else {
//         emit(state.copyWith(QuizStateType.quizFinished));
//       }
//     });

//     on<TimeOut>((event, emit) {
//       emit(state.copyWith(QuizStateType.answerIncorrect));
//       add(NextQuestion());
//     });
//   }
//   void startTimer() {
//     timer = Timer(const Duration(seconds: 30), () => add(TimeOut()));
//   }

//   @override
//   Future<void> close() {
//     timer?.cancel();
//     return super.close();
//   }
// }

class QuizConfigurationBloc
    extends Bloc<QuizConfigurationEvent, QuizConfigurationState> {
  // final CustomizeQuizRepo quizRepo;
  late List<Question> questions;
  int currentQuestionIndex = 0;
  Timer? timer;
  String? selectedAnswer;
  QuizConfigurationBloc()
      : currentQuestionIndex = 0,
        super(QuizConfigurationState.initial()) {
    on<StartQuiz>((event, emit) async {
      CustomizeQuizRepo quizRepo = CustomizeQuizRepo();
      questions = await quizRepo.fetchQuiz(
        amount: event.amount,
        category: event.category,
        difficulty: event.difficulty,
        type: event.type,
      );

      emit(state.copyWith(
        QuizStateType.questionLoaded,
        // currentQuestion: questions[currentQuestionIndex]
      ));
      startTimer();
    });
    on<AnswerQuestion>((event, emit) {
      timer?.cancel();
      if (questions[currentQuestionIndex].correctAnswer == selectedAnswer) {
        emit(state.copyWith(QuizStateType.answerCorrect));
      } else {
        emit(state.copyWith(QuizStateType.answerIncorrect));
      }
      add(NextQuestion());
    });

    on<NextQuestion>((event, emit) {
      if (++currentQuestionIndex < questions.length) {
        emit(state.copyWith(QuizStateType.questionLoaded,
            currentQuestion: questions[currentQuestionIndex]));
        startTimer();
      } else {
        emit(state.copyWith(QuizStateType.quizFinished));
      }
    });

    on<TimeOut>((event, emit) {
      emit(state.copyWith(QuizStateType.answerIncorrect));
      add(NextQuestion());
    });
  }
  void startTimer() {
    timer = Timer(const Duration(seconds: 30), () => add(TimeOut()));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
