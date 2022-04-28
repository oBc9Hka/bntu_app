enum QuizTypes { single_coeff, multiple_coeff }

extension QuizTypesExtension on QuizTypes {
  String get asString {
    switch (this) {
      case QuizTypes.single_coeff:
        return 'single_coeff';
      case QuizTypes.multiple_coeff:
        return 'multiple_coeff';
    }
  }
}

QuizTypes quizTypeFromString(String string) {
  print(QuizTypes.values);
  return QuizTypes.values
      .firstWhere((i) => i.toString() == 'QuizTypes.$string');
}
