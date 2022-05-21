import 'package:freezed_annotation/freezed_annotation.dart';
part 'coeff_model.freezed.dart';

@freezed
class Coeff with _$Coeff {
  const factory Coeff({
    required String key,
    required int weight,
  }) = _Coeff;
  factory Coeff.fromMap(Map<String, dynamic> data) => Coeff(
        key: data['key'],
        weight: data['weight'],
      );
}
