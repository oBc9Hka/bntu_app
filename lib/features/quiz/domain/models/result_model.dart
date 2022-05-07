import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_model.freezed.dart';

@freezed
class Result with _$Result {
  const factory Result({
    required String speciality,
    required String faculty,
  }) = _Result;
}
