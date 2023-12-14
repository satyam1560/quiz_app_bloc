import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_configuration_bloc.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<QuizConfigurationBloc, QuizConfigurationState>(
        builder: (context, state) {
          if (state.type == QuizStateType.questionLoaded) {
            return const Text('loaded');
          }
          return Container(
            color: Colors.red,
          );
          // return Column(
          //   children: [
          //     StreamBuilder<int>(
          //       stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
          //       builder: (context, snapshot) {
          //         final secondsPassed = snapshot.data ?? 0;
          //         final secondsLeft = 30 - secondsPassed;
          //         if (secondsLeft < 0) {
          //           return const Text('Time\'s up!');
          //         } else {
          //           return Text('Time remaining: $secondsLeft seconds');
          //         }
          //       },
          //     ),
          //     if (state.type == QuizStateType.questionLoaded) ...[
          //       Text('Question: ${state.currentQuestion!.question}'),
          //       ...state.currentQuestion!.incorrectAnswers
          //           .map((answer) => ElevatedButton(
          //                 onPressed: () => context
          //                     .read<QuizConfigurationBloc>()
          //                     .add(AnswerQuestion(answer)),
          //                 child: Text(answer),
          //               ))
          //           .toList(),
          //       ElevatedButton(
          //         onPressed: () => context.read<QuizConfigurationBloc>().add(
          //             AnswerQuestion(state.currentQuestion!.correctAnswer)),
          //         child: Text(state.currentQuestion!.correctAnswer),
          //       ),
          //     ],
          //     if (state.type == QuizStateType.answerCorrect)
          //       const Text('Correct!', style: TextStyle(color: Colors.green)),
          //     if (state.type == QuizStateType.answerIncorrect)
          //       const Text('Incorrect!', style: TextStyle(color: Colors.red)),
          //     if (state.type == QuizStateType.quizFinished)
          //       const Text('Quiz Finished!'),
          //   ],
          // );
        },
      ),
    );
  }
}
