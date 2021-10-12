class QuestionModel {
  String? id;
  int? orderId;
  String? question;
  Map<String, dynamic>? answers;

  QuestionModel({this.id, this.orderId, this.question, this.answers});

  QuestionModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          orderId: data['orderId'],
          question: data['question'],
          answers: data['answers'],
        );
}
