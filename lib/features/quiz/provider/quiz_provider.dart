import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  final QuizRepository quizRepository;

  QuizProvider({required this.quizRepository});

  List<QuizModel> quizList = [];
  bool isLoading = false;

  Future<void> getQuizList() async {
    isLoading = true;
    quizList = await quizRepository.getQuizList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addQuiz({
    required String quizName,
    required QuizTypes quizType,
  }) async {
    await quizRepository.addQuiz(
      quiz: QuizModel(
          docId: '',
          quizName: quizName,
          quizType: quizType,
          questions: [],
          isVisible: false),
    );
    notifyListeners();
  }
}
