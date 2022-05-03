class Answer {
  String text;
  List<String> coefficients;

  Answer({
    required this.text,
    required this.coefficients,
  });

  Answer.fromMap(Map<String, dynamic> data)
      : this(
          text: data['text'],
          coefficients: [],
        );
}
