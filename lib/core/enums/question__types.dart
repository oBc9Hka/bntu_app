enum QuestionTypes { single_answer, multiple_answers }

extension QuiestionTypesExtension on QuestionTypes {
  String get asString {
    switch (this) {
      case QuestionTypes.single_answer:
        return 'Один ответ';
      case QuestionTypes.multiple_answers:
        return 'Несколько ответов';
    }
  }
}

QuestionTypes questionTypeFromString(String string) {
  return QuestionTypes.values
      .firstWhere((i) => i.toString() == 'QuestionTypes.$string');
}
