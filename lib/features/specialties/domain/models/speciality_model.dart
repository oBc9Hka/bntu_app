import 'package:bntu_app/features/specialties/domain/models/admission_results.dart';

class Speciality {
  String? id;
  String? facultyBased;
  String? name;
  String? number;
  String? about;
  String? qualification;
  String trainingDurationDayFull; //дневное полное
  String trainingDurationDayShort; //дневное сокращённое
  String trainingDurationCorrespondenceFull; //заочное полное
  String trainingDurationCorrespondenceShort; //заочное сокращённое
  List<dynamic> entranceTestsFull; //вступительные экзамены на полное
  List<dynamic> entranceShort; //вступительные экзамены на сокращённое
  List<AdmissionResults> admissions; // данные вступительных компаний

  Speciality({
    this.id,
    this.facultyBased,
    this.name,
    this.number,
    this.about,
    this.qualification,
    this.trainingDurationDayFull = '',
    this.trainingDurationDayShort = '',
    this.trainingDurationCorrespondenceFull = '',
    this.trainingDurationCorrespondenceShort = '',
    this.entranceTestsFull = const [],
    this.entranceShort = const [],
    this.admissions = const [],
  });

  Speciality.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String?,
          facultyBased: json['facultyBased'] as String?,
          name: json['name'] as String?,
          number: json['number'] as String?,
          about: json['about'] as String?,
          qualification: json['qualification'] as String?,
          trainingDurationDayFull: json['trainingDurationDayFull'] as String,
          trainingDurationDayShort: json['trainingDurationDayShort'] as String,
          trainingDurationCorrespondenceFull:
              json['trainingDurationCorrespondenceFull'] as String,
          trainingDurationCorrespondenceShort:
              json['trainingDurationCorrespondenceShort'] as String,
          entranceTestsFull: json['entranceTestsFull'] as List<dynamic>,
          entranceShort: json['entranceShort'] as List<dynamic>,
          admissions: (json['admissions'] as List<dynamic>)
              .map((e) => AdmissionResults.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'facultyBased': facultyBased,
        'name': name,
        'number': number,
        'about': about,
        'qualification': qualification,
        'trainingDurationDayFull': trainingDurationDayFull,
        'trainingDurationDayShort': trainingDurationDayShort,
        'trainingDurationCorrespondenceFull':
            trainingDurationCorrespondenceFull,
        'trainingDurationCorrespondenceShort':
            trainingDurationCorrespondenceShort,
        'entranceTestsFull': entranceTestsFull,
        'entranceShort': entranceShort,
        'admissions': admissions
            .map((e) => {
                  'year': e.year,
                  'places': e.places.toJson(),
                  'scores': e.scores.toJson(),
                })
            .toList(),
      };
}
