import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/custimize_quiz_repo.dart';
import '../bloc/quiz_configuration_bloc.dart';
import 'quiz_page.dart';

enum TotalQuestions {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten
}

enum Difficulty { easy, medium, hard }

enum Type { multiple, boolean }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TotalQuestions selectedQuestionCount = TotalQuestions.one;
  Difficulty selectedDifficulty = Difficulty.easy;
  Type selectedType = Type.multiple;
  Map<String, int> categories = {
    'General Knowledge': 9,
    'Entertainment: Books': 10,
    'Entertainment: Film': 11,
    'TV Trivia': 14,
    'Music Trivia': 12,
    'Science & Math Trivia': 17,
    'Geography Trivia': 22,
    'History Trivia': 23,
    'Sports Trivia': 21,
    'Literature Trivia': 13,
    'Religion Trivia': 20,
  };
  String selectedCategory = 'General Knowledge';

  CustomizeQuizRepo customizeQuizRepo = CustomizeQuizRepo();

  void fetchQuiz() {
    final amount = selectedQuestionCount.index + 1;
    const category = 19;
    final difficulty = selectedDifficulty.toString().split('.').last;
    final type = selectedType.toString().split('.').last;

    BlocProvider.of<QuizConfigurationBloc>(context).add(
      StartQuiz(
        amount: amount,
        category: category,
        difficulty: difficulty,
        type: type,
      ),
    );

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const QuizPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komodo Trivia'),
        backgroundColor: Colors.blue, // Adjust the color as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<TotalQuestions>(
              value: selectedQuestionCount,
              onChanged: (TotalQuestions? newValue) {
                setState(() {
                  selectedQuestionCount = newValue!;
                });
              },
              items: [
                for (TotalQuestions value in TotalQuestions.values)
                  DropdownMenuItem<TotalQuestions>(
                    value: value,
                    child: Text(
                      '${value.index + 1}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButton<Difficulty>(
              value: selectedDifficulty,
              onChanged: (Difficulty? newValue) {
                setState(() {
                  selectedDifficulty = newValue!;
                });
              },
              items: [
                for (Difficulty value in Difficulty.values)
                  DropdownMenuItem<Difficulty>(
                    value: value,
                    child: Text(
                      value.toString().split('.').last,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButton<Type>(
              value: selectedType,
              onChanged: (Type? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: [
                for (Type value in Type.values)
                  DropdownMenuItem<Type>(
                    value: value,
                    child: Text(
                      value.toString().split('.').last,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  fetchQuiz();
                });
              },
              items: [
                for (String category in categories.keys)
                  DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32.0),
            BlocListener<QuizConfigurationBloc, QuizConfigurationState>(
              listener: (context, state) {
                if (state.type == QuizStateType.questionLoaded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                }
              },
              child: ElevatedButton(
                onPressed: fetchQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Adjust the color as needed
                  textStyle: const TextStyle(fontSize: 18.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                ),
                child: const Text('Start Quiz'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
