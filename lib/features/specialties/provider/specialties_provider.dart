import 'package:flutter/foundation.dart';

import '../domain/models/speciality_model.dart';
import '../domain/repository/specialties_repository.dart';

class SpecialtiesProvider with ChangeNotifier {
  final SpecialtiesRepository specialtiesRepository;

  List<Speciality> specialties = [];

  String currentAdmissionYear = '2021';

  bool isLoading = false;

  SpecialtiesProvider({required this.specialtiesRepository}) {
    initSpecialties();
  }

  void initSpecialties({List<String>? qualificationNeedToShow}) async {
    isLoading = true;
    notifyListeners();
    final specialtiesResult = await specialtiesRepository.getSpecialtiesList();
    specialties = [];
    if (qualificationNeedToShow != null) {
      for (var item in specialtiesResult) {
        if (qualificationNeedToShow.contains(item.qualification)) {
          specialties.add(item);
        }
      }
    } else {
      specialties = specialtiesResult;
    }
    isLoading = false;
    notifyListeners();
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
    specialtiesRepository.addSpeciality(
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
    notifyListeners();
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
    specialtiesRepository.editSpeciality(
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
    notifyListeners();
  }

  void removeSpeciality(String id) {
    specialtiesRepository.removeSpeciality(id);
    notifyListeners();
  }
}
