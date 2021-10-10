import 'package:bntu_app/models/error_message_model.dart';
import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/models/speciality_model.dart';

abstract class FacultiesRepository {
  const FacultiesRepository();

  Future<List<Faculty>> getFacultiesList();

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

abstract class BuildingsRepository {}

abstract class QuestionsRepository {}

abstract class ErrorMessagesRepository {
  Future<List<ErrorMessage>> getErrorMessagesList();

  Future<void> submitErrorMessage(String msg);

  Future<void> changeViewedState(String id);

  Future<void> removeErrorMessage(String id);

  Future<String> getUnseenMessages();
}

abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<void> editSettings(String currentAdmissionYear, String key);
}
