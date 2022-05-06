import 'package:bntu_app/core/enums/question__types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer_model.dart';
part 'question_model.freezed.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String question,
    required QuestionTypes questionType,
    required List<Answer> answers,
  }) = _QuestionModel;

  factory QuestionModel.fromMap(Map<String, dynamic> data) => QuestionModel(
        question: data['question'],
        questionType: questionTypeFromString(data['questionType']),
        answers: [
          ...data['answers'].map(
            (e) => Answer.fromMap(e),
          ),
        ],
      );
}
