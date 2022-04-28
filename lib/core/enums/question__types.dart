enum QuiestionTypes { single_answer, multiple_answers }

QuiestionTypes questionTypeFromString(String string) {
  return QuiestionTypes.values
      .firstWhere((i) => i.toString() == 'QuiestionTypes.$String');
}
