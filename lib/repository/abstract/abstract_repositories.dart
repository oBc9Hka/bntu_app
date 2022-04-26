import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/features/greetings/domain/models/error_message_model.dart';
import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/models/speciality_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class FacultiesRepository {
  const FacultiesRepository();

  Future<List<Faculty>> getFacultiesList();

  Future<List<String>> getFacultiesShortNames();

  Future<Faculty> getFacultyByShortName(String name);

  Future<void> addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
  );

  Future<void> editFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
    String id,
  );

  Future<void> removeFaculty(String id, String name);
}

abstract class SpecialtiesRepository {
  const SpecialtiesRepository();

  Future<List<Speciality>> getSpecialtiesList();

  Future<void> addSpeciality(
    String facultyBased,
    String name,
    String number,
    String about,
    String qualification,
    String trainingDurationDayFull,
    String trainingDurationDayShort,
    String trainingDurationCorrespondenceFull,
    String trainingDurationCorrespondenceShort,
    List<String> entranceTestsFull,
    List<String> entranceShort,
    String admissionCurrentDayFullBudget,
    String admissionCurrentDayShortBudget,
    String admissionCurrentDayFullPaid,
    String admissionCurrentDayShortPaid,
    String admissionCurrentCorrespondenceFullBudget,
    String admissionCurrentCorrespondenceShortBudget,
    String admissionCurrentCorrespondenceFullPaid,
    String admissionCurrentCorrespondenceShortPaid,
    String passScorePrevYearDayFullBudget,
    String passScorePrevYearDayShortBudget,
    String passScorePrevYearDayFullPaid,
    String passScorePrevYearDayShortPaid,
    String passScorePrevYearCorrespondenceFullBudget,
    String passScorePrevYearCorrespondenceShortBudget,
    String passScorePrevYearCorrespondenceFullPaid,
    String passScorePrevYearCorrespondenceShortPaid,
    String admissionPrevYearDayFullBudget,
    String admissionPrevYearDayShortBudget,
    String admissionPrevYearDayFullPaid,
    String admissionPrevYearDayShortPaid,
    String admissionPrevYearCorrespondenceFullBudget,
    String admissionPrevYearCorrespondenceShortBudget,
    String admissionPrevYearCorrespondenceFullPaid,
    String admissionPrevYearCorrespondenceShortPaid,
    String passScoreBeforeLastYearDayFullBudget,
    String passScoreBeforeLastYearDayShortBudget,
    String passScoreBeforeLastYearDayFullPaid,
    String passScoreBeforeLastYearDayShortPaid,
    String passScoreBeforeLastYearCorrespondenceFullBudget,
    String passScoreBeforeLastYearCorrespondenceShortBudget,
    String passScoreBeforeLastYearCorrespondenceFullPaid,
    String passScoreBeforeLastYearCorrespondenceShortPaid,
  );

  Future<void> editSpeciality(
    String facultyBased,
    String name,
    String number,
    String about,
    String qualification,
    String trainingDurationDayFull,
    String trainingDurationDayShort,
    String trainingDurationCorrespondenceFull,
    String trainingDurationCorrespondenceShort,
    List<String> entranceTestsFull,
    List<String> entranceShort,
    String admissionCurrentDayFullBudget,
    String admissionCurrentDayShortBudget,
    String admissionCurrentDayFullPaid,
    String admissionCurrentDayShortPaid,
    String admissionCurrentCorrespondenceFullBudget,
    String admissionCurrentCorrespondenceShortBudget,
    String admissionCurrentCorrespondenceFullPaid,
    String admissionCurrentCorrespondenceShortPaid,
    String passScorePrevYearDayFullBudget,
    String passScorePrevYearDayShortBudget,
    String passScorePrevYearDayFullPaid,
    String passScorePrevYearDayShortPaid,
    String passScorePrevYearCorrespondenceFullBudget,
    String passScorePrevYearCorrespondenceShortBudget,
    String passScorePrevYearCorrespondenceFullPaid,
    String passScorePrevYearCorrespondenceShortPaid,
    String admissionPrevYearDayFullBudget,
    String admissionPrevYearDayShortBudget,
    String admissionPrevYearDayFullPaid,
    String admissionPrevYearDayShortPaid,
    String admissionPrevYearCorrespondenceFullBudget,
    String admissionPrevYearCorrespondenceShortBudget,
    String admissionPrevYearCorrespondenceFullPaid,
    String admissionPrevYearCorrespondenceShortPaid,
    String passScoreBeforeLastYearDayFullBudget,
    String passScoreBeforeLastYearDayShortBudget,
    String passScoreBeforeLastYearDayFullPaid,
    String passScoreBeforeLastYearDayShortPaid,
    String passScoreBeforeLastYearCorrespondenceFullBudget,
    String passScoreBeforeLastYearCorrespondenceShortBudget,
    String passScoreBeforeLastYearCorrespondenceFullPaid,
    String passScoreBeforeLastYearCorrespondenceShortPaid,
    String id,
  );

  Future<void> removeSpeciality(String id);
}

abstract class InfoCardsRepository {
  Future<List<InfoCard>> getCards();

  Future<void> addCard(String title, String subtitle);

  Future<void> editCard(String title, String subtitle, String id);

  Future<void> removeCard(String id);

  Future<void> moveUp(String currId, String prevId);

  Future<void> moveDown(String currId, String nextId);
}

abstract class BuildingsRepository {
  Future<List<Building>> getBuildingsList();

  Future<void> addBuilding(
      String name, String optional, Point point, String imagePath);

  Future<void> editBuilding(
      String name, String optional, Point point, String imagePath, String id);

  Future<void> removeBuilding(String id);

  Future<void> moveUp(String currId, String prevId);

  Future<void> moveDown(String currId, String nextId);
}

abstract class QuestionsRepository {
  Future<List<QuestionModel>> getQuestionsList(String collection);

  Future<void> addQuestion(
      String collection, String question, List<Map<String, dynamic>> answers);

  Future<void> editQuestion(String collection, String id, String question,
      List<Map<String, dynamic>> answers);

  Future<void> removeQuestion(String collection, String id);

  Future<void> moveUp(String collection, String currId, String prevId);

  Future<void> moveDown(String collection, String currId, String nextId);
}

abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<bool> getIsFacultyQuizChecked();

  Future<void> editQuizChecked(bool isFacultiesQuiz);

  Future<void> editSettings(String currentAdmissionYear, String key);
}
