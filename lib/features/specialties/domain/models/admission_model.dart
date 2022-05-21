import 'package:json_annotation/json_annotation.dart';

part 'admission_model.g.dart';

@JsonSerializable()
class AdmissionModel {
  String? fullBudget;
  String? shortBudget;
  String? fullPaid;
  String? shortPaid;

  AdmissionModel({
    this.fullBudget,
    this.shortBudget,
    this.fullPaid,
    this.shortPaid,
  });

  factory AdmissionModel.fromJson(Map<String, dynamic> json) =>
      _$AdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionModelToJson(this);
}
