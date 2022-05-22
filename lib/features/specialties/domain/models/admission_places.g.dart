// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionInfo _$AdmissionInfoFromJson(Map<String, dynamic> json) =>
    AdmissionInfo(
      day: AdmissionModel.fromJson(json['day'] as Map<String, dynamic>),
      correspondence: AdmissionModel.fromJson(
          json['correspondence'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdmissionInfoToJson(AdmissionInfo instance) =>
    <String, dynamic>{
      'day': instance.day,
      'correspondence': instance.correspondence,
    };
