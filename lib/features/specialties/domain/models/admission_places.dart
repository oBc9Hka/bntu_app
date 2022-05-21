import 'package:bntu_app/features/specialties/domain/models/admission_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'admission_places.g.dart';

@JsonSerializable()
class AdmissionInfo {
  AdmissionModel? day;
  AdmissionModel? correspondence;

  AdmissionInfo({
    this.day,
    this.correspondence,
  });

  factory AdmissionInfo.fromJson(Map<String, dynamic> json) =>
      _$AdmissionInfoFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'day': day?.toJson(),
        'correspondence': correspondence?.toJson(),
      };
}
