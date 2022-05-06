import 'package:bntu_app/features/quiz/domain/models/coeff_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.freezed.dart';

@freezed
class Answer with _$Answer {
  const factory Answer({
    required String text,
    required List<Coeff> coefficients,
  }) = _Answer;

  factory Answer.fromMap(Map<String, dynamic> data) => Answer(
        text: data['text'],
        coefficients: [
          ...data['coefficients'].map(
            (e) => Coeff.fromMap(e),
          ),
        ],
      );
}
