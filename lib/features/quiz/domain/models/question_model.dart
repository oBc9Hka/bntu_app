import 'package:bntu_app/core/enums/question__types.dart';

import 'answer_model.dart';

class QuestionModel {
  String question;
  QuiestionTypes questionType;
  List<Answer> answers;

  QuestionModel({
    required this.question,
    required this.questionType,
    required this.answers,
  });

  QuestionModel.fromMap(Map<String, dynamic> data)
      : this(
          question: data['question'],
          questionType: questionTypeFromString(data['questionType']),
          answers: [
            ...data['answers'].map(
              (e) => Answer.fromMap(e),
            ),
          ],
        );
}
