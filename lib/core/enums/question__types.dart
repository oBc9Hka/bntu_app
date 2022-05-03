enum QuiestionTypes { single_answer, multiple_answers }

extension QuiestionTypesExtension on QuiestionTypes {
  String get asString {
    switch (this) {
      case QuiestionTypes.single_answer:
        return 'single_answer';
      case QuiestionTypes.multiple_answers:
        return 'multiple_answers';
    }
  }
}

QuiestionTypes questionTypeFromString(String string) {
  return QuiestionTypes.values
      .firstWhere((i) => i.toString() == 'QuiestionTypes.$string');
}
