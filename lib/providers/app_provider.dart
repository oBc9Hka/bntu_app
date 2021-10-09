import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  final FacultiesRepository _facultiesRepository;
  final SpecialtiesRepository _specialtiesRepository;
  final SettingsRepository _settingsRepository;

  List<Faculty> faculties = [];

  bool get isFacultiesLoaded => faculties.isNotEmpty;

  List<Speciality> specialties = [];

  bool get isSpecialtiesLoaded => specialties.isNotEmpty;

  String currentAdmissionYear = '';
  late String secretKey;

  AppProvider(this._facultiesRepository, this._specialtiesRepository,
      this._settingsRepository) {
    initFaculties();
    initSpecialties();
    initSettings();
  }

  void initFaculties() async {
    faculties = await _facultiesRepository.getFacultiesList();
    notifyListeners();
  }

  void initSpecialties() async {
    specialties = await _specialtiesRepository.getSpecialtiesList();
    notifyListeners();
  }

  void initSettings() async {
    currentAdmissionYear = await _settingsRepository.getCurrentAdmissionYear();
    secretKey = await _settingsRepository.getSecretKey();
    notifyListeners();
  }

  void addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
  ) {
    try {
      _facultiesRepository.addFaculty(
        name,
        shortName,
        about,
        hotLineNumber,
        hotLineMail,
        forInquiriesNumber,
        forHostelNumber,
        imagePath,
      );
    } catch (e) {
      throw 'Непредвиденная ошибка: $e';
    }
    notifyListeners();
  }

  void editFaculty(
      String name,
      String shortName,
      String about,
      String hotLineNumber,
      String hotLineMail,
      String forInquiriesNumber,
      String forHostelNumber,
      String imagePath,
      String id) {
    _facultiesRepository.editFaculty(
      name,
      shortName,
      about,
      hotLineNumber,
      hotLineMail,
      forInquiriesNumber,
      forHostelNumber,
      imagePath,
      id,
    );
  }

  void removeFaculty(String id, String packageName) {
    _facultiesRepository.removeFaculty(id, packageName);
  }

  void addSpeciality(
    facultyBased,
    name,
    number,
    about,
    qualification,
    trainingDurationDayFull,
    trainingDurationDayShort,
    trainingDurationCorrespondenceFull,
    trainingDurationCorrespondenceShort,
    entranceTestsFull,
    entranceShort,
    admissionCurrentDayFullBudget,
    admissionCurrentDayShortBudget,
    admissionCurrentDayFullPaid,
    admissionCurrentDayShortPaid,
    admissionCurrentCorrespondenceFullBudget,
    admissionCurrentCorrespondenceShortBudget,
    admissionCurrentCorrespondenceFullPaid,
    admissionCurrentCorrespondenceShortPaid,
    passScorePrevYearDayFullBudget,
    passScorePrevYearDayShortBudget,
    passScorePrevYearDayFullPaid,
    passScorePrevYearDayShortPaid,
    passScorePrevYearCorrespondenceFullBudget,
    passScorePrevYearCorrespondenceShortBudget,
    passScorePrevYearCorrespondenceFullPaid,
    passScorePrevYearCorrespondenceShortPaid,
    admissionPrevYearDayFullBudget,
    admissionPrevYearDayShortBudget,
    admissionPrevYearDayFullPaid,
    admissionPrevYearDayShortPaid,
    admissionPrevYearCorrespondenceFullBudget,
    admissionPrevYearCorrespondenceShortBudget,
    admissionPrevYearCorrespondenceFullPaid,
    admissionPrevYearCorrespondenceShortPaid,
    passScoreBeforeLastYearDayFullBudget,
    passScoreBeforeLastYearDayShortBudget,
    passScoreBeforeLastYearDayFullPaid,
    passScoreBeforeLastYearDayShortPaid,
    passScoreBeforeLastYearCorrespondenceFullBudget,
    passScoreBeforeLastYearCorrespondenceShortBudget,
    passScoreBeforeLastYearCorrespondenceFullPaid,
    passScoreBeforeLastYearCorrespondenceShortPaid,
  ) {
    _specialtiesRepository.addSpeciality(
      facultyBased,
      name,
      number,
      about,
      qualification,
      trainingDurationDayFull,
      trainingDurationDayShort,
      trainingDurationCorrespondenceFull,
      trainingDurationCorrespondenceShort,
      entranceTestsFull,
      entranceShort,
      admissionCurrentDayFullBudget,
      admissionCurrentDayShortBudget,
      admissionCurrentDayFullPaid,
      admissionCurrentDayShortPaid,
      admissionCurrentCorrespondenceFullBudget,
      admissionCurrentCorrespondenceShortBudget,
      admissionCurrentCorrespondenceFullPaid,
      admissionCurrentCorrespondenceShortPaid,
      passScorePrevYearDayFullBudget,
      passScorePrevYearDayShortBudget,
      passScorePrevYearDayFullPaid,
      passScorePrevYearDayShortPaid,
      passScorePrevYearCorrespondenceFullBudget,
      passScorePrevYearCorrespondenceShortBudget,
      passScorePrevYearCorrespondenceFullPaid,
      passScorePrevYearCorrespondenceShortPaid,
      admissionPrevYearDayFullBudget,
      admissionPrevYearDayShortBudget,
      admissionPrevYearDayFullPaid,
      admissionPrevYearDayShortPaid,
      admissionPrevYearCorrespondenceFullBudget,
      admissionPrevYearCorrespondenceShortBudget,
      admissionPrevYearCorrespondenceFullPaid,
      admissionPrevYearCorrespondenceShortPaid,
      passScoreBeforeLastYearDayFullBudget,
      passScoreBeforeLastYearDayShortBudget,
      passScoreBeforeLastYearDayFullPaid,
      passScoreBeforeLastYearDayShortPaid,
      passScoreBeforeLastYearCorrespondenceFullBudget,
      passScoreBeforeLastYearCorrespondenceShortBudget,
      passScoreBeforeLastYearCorrespondenceFullPaid,
      passScoreBeforeLastYearCorrespondenceShortPaid,
    );
  }

  void editSpeciality(
    facultyBased,
    name,
    number,
    about,
    qualification,
    trainingDurationDayFull,
    trainingDurationDayShort,
    trainingDurationCorrespondenceFull,
    trainingDurationCorrespondenceShort,
    entranceTestsFull,
    entranceShort,
    admissionCurrentDayFullBudget,
    admissionCurrentDayShortBudget,
    admissionCurrentDayFullPaid,
    admissionCurrentDayShortPaid,
    admissionCurrentCorrespondenceFullBudget,
    admissionCurrentCorrespondenceShortBudget,
    admissionCurrentCorrespondenceFullPaid,
    admissionCurrentCorrespondenceShortPaid,
    passScorePrevYearDayFullBudget,
    passScorePrevYearDayShortBudget,
    passScorePrevYearDayFullPaid,
    passScorePrevYearDayShortPaid,
    passScorePrevYearCorrespondenceFullBudget,
    passScorePrevYearCorrespondenceShortBudget,
    passScorePrevYearCorrespondenceFullPaid,
    passScorePrevYearCorrespondenceShortPaid,
    admissionPrevYearDayFullBudget,
    admissionPrevYearDayShortBudget,
    admissionPrevYearDayFullPaid,
    admissionPrevYearDayShortPaid,
    admissionPrevYearCorrespondenceFullBudget,
    admissionPrevYearCorrespondenceShortBudget,
    admissionPrevYearCorrespondenceFullPaid,
    admissionPrevYearCorrespondenceShortPaid,
    passScoreBeforeLastYearDayFullBudget,
    passScoreBeforeLastYearDayShortBudget,
    passScoreBeforeLastYearDayFullPaid,
    passScoreBeforeLastYearDayShortPaid,
    passScoreBeforeLastYearCorrespondenceFullBudget,
    passScoreBeforeLastYearCorrespondenceShortBudget,
    passScoreBeforeLastYearCorrespondenceFullPaid,
    passScoreBeforeLastYearCorrespondenceShortPaid,
    id,
  ) {
    _specialtiesRepository.editSpeciality(
      facultyBased,
      name,
      number,
      about,
      qualification,
      trainingDurationDayFull,
      trainingDurationDayShort,
      trainingDurationCorrespondenceFull,
      trainingDurationCorrespondenceShort,
      entranceTestsFull,
      entranceShort,
      admissionCurrentDayFullBudget,
      admissionCurrentDayShortBudget,
      admissionCurrentDayFullPaid,
      admissionCurrentDayShortPaid,
      admissionCurrentCorrespondenceFullBudget,
      admissionCurrentCorrespondenceShortBudget,
      admissionCurrentCorrespondenceFullPaid,
      admissionCurrentCorrespondenceShortPaid,
      passScorePrevYearDayFullBudget,
      passScorePrevYearDayShortBudget,
      passScorePrevYearDayFullPaid,
      passScorePrevYearDayShortPaid,
      passScorePrevYearCorrespondenceFullBudget,
      passScorePrevYearCorrespondenceShortBudget,
      passScorePrevYearCorrespondenceFullPaid,
      passScorePrevYearCorrespondenceShortPaid,
      admissionPrevYearDayFullBudget,
      admissionPrevYearDayShortBudget,
      admissionPrevYearDayFullPaid,
      admissionPrevYearDayShortPaid,
      admissionPrevYearCorrespondenceFullBudget,
      admissionPrevYearCorrespondenceShortBudget,
      admissionPrevYearCorrespondenceFullPaid,
      admissionPrevYearCorrespondenceShortPaid,
      passScoreBeforeLastYearDayFullBudget,
      passScoreBeforeLastYearDayShortBudget,
      passScoreBeforeLastYearDayFullPaid,
      passScoreBeforeLastYearDayShortPaid,
      passScoreBeforeLastYearCorrespondenceFullBudget,
      passScoreBeforeLastYearCorrespondenceShortBudget,
      passScoreBeforeLastYearCorrespondenceFullPaid,
      passScoreBeforeLastYearCorrespondenceShortPaid,
      id,
    );
  }
  void removeSpeciality(String id){
    _specialtiesRepository.removeSpeciality(id);
  }
}
