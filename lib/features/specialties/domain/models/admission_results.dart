import 'package:bntu_app/features/specialties/domain/models/admission_places.dart';

import 'package:json_annotation/json_annotation.dart';

part 'admission_results.g.dart';

@JsonSerializable()
class AdmissionResults {
  String year;
  AdmissionInfo? places;
  AdmissionInfo? scores;

  AdmissionResults({
    required this.year,
    this.places,
    this.scores,
  });

  factory AdmissionResults.fromJson(Map<String, dynamic> json) =>
      _$AdmissionResultsFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'year': year,
        'places': places?.toJson(),
        'scores': scores?.toJson(),
      };
}
