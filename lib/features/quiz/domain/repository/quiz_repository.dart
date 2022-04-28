import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';

import '../models/question_model.dart';

abstract class QuizRepository {
  Future<List<QuestionModel>> getQuestionsList({required String collection});

  Future<bool> addQuiz({required QuizModel quiz});

  Future<bool> editQuiz({required QuizModel quiz});

  Future<bool> deleteQuiz({required String quizName});

  Future<List<QuizModel>> getQuizList();
}
