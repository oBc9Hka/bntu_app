enum QuestionTypes { single_answer, multiple_answers }

extension QuiestionTypesExtension on QuestionTypes {
  String get asString {
    switch (this) {
      case QuestionTypes.single_answer:
        return 'single_answer';
      case QuestionTypes.multiple_answers:
        return 'multiple_answers';
    }
  }
}

QuestionTypes questionTypeFromString(String string) {
  return QuestionTypes.values
      .firstWhere((i) => i.toString() == 'QuestionTypes.$string');
}
