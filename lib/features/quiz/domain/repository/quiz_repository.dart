import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';

abstract class QuizRepository {
  Future<bool> addQuiz({required QuizModel quiz});

  Future<bool> editQuiz({required QuizModel quiz});

  Future<bool> deleteQuiz({required QuizModel quiz});

  Future<List<QuizModel?>> getQuizList({required List<String> quizIds});
}
