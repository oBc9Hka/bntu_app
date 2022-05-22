// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionResults _$AdmissionResultsFromJson(Map<String, dynamic> json) =>
    AdmissionResults(
      year: json['year'] as String,
      places: AdmissionInfo.fromJson(json['places'] as Map<String, dynamic>),
      scores: AdmissionInfo.fromJson(json['scores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdmissionResultsToJson(AdmissionResults instance) =>
    <String, dynamic>{
      'year': instance.year,
      'places': instance.places,
      'scores': instance.scores,
    };
