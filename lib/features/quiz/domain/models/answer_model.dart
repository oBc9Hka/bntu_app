import 'package:bntu_app/features/quiz/domain/models/coeff_model.dart';

class Answer {
  String text;
  List<Coeff> coefficients;

  Answer({
    required this.text,
    required this.coefficients,
  });

  Answer.fromMap(Map<String, dynamic> data)
      : this(
          text: data['text'],
          coefficients: [
            ...data['coefficients'].map(
              (e) => Coeff.fromMap(e),
            ),
          ],
        );
}
