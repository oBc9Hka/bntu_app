// ignore_for_file: must_be_immutable

import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:equatable/equatable.dart';

class QuizModel extends Equatable {
  String docId;
  String quizName;
  QuizTypes quizType;
  List<QuestionModel>? questions;
  bool isVisible; // for future ability to show multiple tests

  QuizModel({
    required this.docId,
    required this.quizName,
    required this.quizType,
    required this.questions,
    required this.isVisible,
  });

  @override
  List<Object?> get props => [docId, quizName, quizType, questions, isVisible];
}
