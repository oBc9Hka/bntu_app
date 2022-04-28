import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';

class QuizModel {
  String docId;
  String quizName;
  QuizTypes quizType;
  List<QuestionModel>? questions;
  bool isVisible;

  QuizModel({
    required this.docId,
    required this.quizName,
    required this.quizType,
    required this.questions,
    required this.isVisible,
  });
}
