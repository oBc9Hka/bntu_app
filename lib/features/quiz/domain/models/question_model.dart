import 'package:bntu_app/core/enums/question__types.dart';

import 'answer_model.dart';

class QuestionModel {
  String question;
  QuiestionTypes quiestionType;
  List<Answer> answers;

  QuestionModel({
    required this.question,
    required this.quiestionType,
    required this.answers,
  });

  QuestionModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          question: data['question'],
          quiestionType: questionTypeFromString(data['questionType']),
          answers: data['answers'],
        );
}
