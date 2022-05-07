import 'package:bntu_app/features/quiz/domain/models/result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'coeff_result_model.freezed.dart';

@freezed
class CoeffResult with _$CoeffResult {
  const factory CoeffResult({
    required String name,
    required List<Result> results,
  }) = _CoeffResult;
}
