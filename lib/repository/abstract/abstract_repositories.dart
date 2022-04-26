import 'package:bntu_app/models/question_model.dart';

abstract class QuestionsRepository {
  Future<List<QuestionModel>> getQuestionsList(String collection);

  Future<void> addQuestion(
      String collection, String question, List<Map<String, dynamic>> answers);

  Future<void> editQuestion(String collection, String id, String question,
      List<Map<String, dynamic>> answers);

  Future<void> removeQuestion(String collection, String id);

  Future<void> moveUp(String collection, String currId, String prevId);

  Future<void> moveDown(String collection, String currId, String nextId);
}
