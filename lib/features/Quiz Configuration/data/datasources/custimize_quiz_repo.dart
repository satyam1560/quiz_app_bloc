import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/question_model.dart';

class CustomizeQuizRepo {
  Future<List<Question>> fetchQuiz({
    required int amount,
    required int category,
    required String difficulty,
    required String type,
  }) async {
    String url =
        'https://opentdb.com/api.php?amount=$amount&category=$category&difficulty=$difficulty&type=$type';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var results = jsonResponse['results'] as List;
      print('results $results');
      List<Question> questions =
          results.map((e) => Question.fromJson(e)).toList();

      for (var question in questions) {
        print('Type: ${question.type}');
        print('Difficulty: ${question.difficulty}');
        print('Category: ${question.category}');
        print('Question: ${question.question}');
        print('Correct Answer: ${question.correctAnswer}');
        print('Incorrect Answers: ${question.incorrectAnswers}');
        print('\n');
      }

      return questions;
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}
