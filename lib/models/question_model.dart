class QuestionModel {
  String? id;
  int? orderId;
  String? question;
  // List<Map<String,List<String>>>? answers;
  List<dynamic>? answers;

  QuestionModel({
    this.id,
    this.orderId,
    this.question,
    this.answers,
  });

  QuestionModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          orderId: data['orderId'],
          question: data['question'],
          answers: data['answers'],
        );
}
