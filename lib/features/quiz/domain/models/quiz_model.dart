import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';

@freezed
class QuizModel with _$QuizModel {
  const factory QuizModel({
    required String docId,
    required String quizName,
    required QuizTypes quizType,
    required List<QuestionModel> questions,
    required bool isVisible,
  }) = _QuizModel;
}
