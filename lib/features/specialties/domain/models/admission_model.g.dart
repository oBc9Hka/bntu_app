// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionModel _$AdmissionModelFromJson(Map<String, dynamic> json) =>
    AdmissionModel(
      fullBudget: json['fullBudget'] as String?,
      shortBudget: json['shortBudget'] as String?,
      fullPaid: json['fullPaid'] as String?,
      shortPaid: json['shortPaid'] as String?,
    );

Map<String, dynamic> _$AdmissionModelToJson(AdmissionModel instance) =>
    <String, dynamic>{
      'fullBudget': instance.fullBudget,
      'shortBudget': instance.shortBudget,
      'fullPaid': instance.fullPaid,
      'shortPaid': instance.shortPaid,
    };
