import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/core/domain/models/error_message_model.dart';
import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:bntu_app/features/admission_info/domain/models/info_cards_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

const String TEST_ID = '1';
const String TEST_NAME = 'Test';

const String TEST_SHORT_NAME = 'shortName';
const String TEST_ABOUT = 'about';

const String TEST_HOTLINE_NUMBER = 'hotLineNumber';
const String TEST_HOTLINE_MAIL = 'hotLineMail';

const String TEST_FOR_INQUIRES_NUMBER = 'forInquiriesNumber';
const String TEST_FOR_HOSTEL_NUMBER = 'forHostelNumber';

const String TEST_IMAGE_PATH = 'imagePath';
const String TEST_NUMBER = 'number';

final testFaculty = Faculty(
  id: TEST_ID,
  name: TEST_NAME,
  shortName: TEST_SHORT_NAME,
  about: TEST_ABOUT,
  hotLineNumber: TEST_HOTLINE_NUMBER,
  hotLineMail: TEST_HOTLINE_MAIL,
  forInquiriesNumber: TEST_FOR_INQUIRES_NUMBER,
  forHostelNumber: TEST_FOR_HOSTEL_NUMBER,
  imagePath: TEST_IMAGE_PATH,
);

final testSpeciality = Speciality(
  id: TEST_ID,
  facultyBased: 'facultyBased',
  name: 'name',
  number: 'number',
  about: 'about',
  qualification: 'qualification',
  trainingDurationDayFull: 'trainingDurationDayFull',
  trainingDurationDayShort: 'trainingDurationDayShort',
  trainingDurationCorrespondenceFull: 'trainingDurationCorrespondenceFull',
  trainingDurationCorrespondenceShort: 'trainingDurationCorrespondenceShort',
  entranceTestsFull: [],
  entranceShort: [],
  admissionCurrentDayFullBudget: 'admissionCurrentDayFullBudget',
  admissionCurrentDayShortBudget: 'admissionCurrentDayShortBudget',
  admissionCurrentDayFullPaid: 'admissionCurrentDayFullPaid',
  admissionCurrentDayShortPaid: 'admissionCurrentDayShortPaid',
  admissionCurrentCorrespondenceFullBudget:
      'admissionCurrentCorrespondenceFullBudget',
  admissionCurrentCorrespondenceShortBudget:
      'admissionCurrentCorrespondenceShortBudget',
  admissionCurrentCorrespondenceFullPaid:
      'admissionCurrentCorrespondenceFullPaid',
  admissionCurrentCorrespondenceShortPaid:
      'admissionCurrentCorrespondenceShortPaid',
  passScorePrevYearDayFullBudget: 'passScorePrevYearDayFullBudget',
  passScorePrevYearDayShortBudget: 'passScorePrevYearDayShortBudget',
  passScorePrevYearDayFullPaid: 'passScorePrevYearDayFullPaid',
  passScorePrevYearDayShortPaid: 'passScorePrevYearDayShortPaid',
  passScorePrevYearCorrespondenceFullBudget:
      'passScorePrevYearCorrespondenceFullBudget',
  passScorePrevYearCorrespondenceShortBudget:
      'passScorePrevYearCorrespondenceShortBudget',
  passScorePrevYearCorrespondenceFullPaid:
      'passScorePrevYearCorrespondenceFullPaid',
  passScorePrevYearCorrespondenceShortPaid:
      'passScorePrevYearCorrespondenceShortPaid',
  admissionPrevYearDayFullBudget: 'admissionPrevYearDayFullBudget',
  admissionPrevYearDayShortBudget: 'admissionPrevYearDayShortBudget',
  admissionPrevYearDayFullPaid: 'admissionPrevYearDayFullPaid',
  admissionPrevYearDayShortPaid: 'admissionPrevYearDayShortPaid',
  admissionPrevYearCorrespondenceFullBudget:
      'admissionPrevYearCorrespondenceFullBudget',
  admissionPrevYearCorrespondenceShortBudget:
      'admissionPrevYearCorrespondenceShortBudget',
  admissionPrevYearCorrespondenceFullPaid:
      'admissionPrevYearCorrespondenceFullPaid',
  admissionPrevYearCorrespondenceShortPaid:
      'admissionPrevYearCorrespondenceShortPaid',
  passScoreBeforeLastYearDayFullBudget: 'passScoreBeforeLastYearDayFullBudget',
  passScoreBeforeLastYearDayShortBudget:
      'passScoreBeforeLastYearDayShortBudget',
  passScoreBeforeLastYearDayFullPaid: 'passScoreBeforeLastYearDayFullPaid',
  passScoreBeforeLastYearDayShortPaid: 'passScoreBeforeLastYearDayShortPaid',
  passScoreBeforeLastYearCorrespondenceFullBudget:
      'passScoreBeforeLastYearCorrespondenceFullBudget',
  passScoreBeforeLastYearCorrespondenceShortBudget:
      'passScoreBeforeLastYearCorrespondenceShortBudget',
  passScoreBeforeLastYearCorrespondenceFullPaid:
      'passScoreBeforeLastYearCorrespondenceFullPaid',
  passScoreBeforeLastYearCorrespondenceShortPaid:
      'passScoreBeforeLastYearCorrespondenceShortPaid',
);

final testInfoCard = InfoCard(
  title: 'title',
  subtitle: 'subtitle',
  orderId: 1,
  docId: 'docId',
);

final testErrorMessage = ErrorMessage(
  message: 'message',
  viewed: false,
);

final testBuilding = Building(
  name: 'name',
  optional: 'optional',
  point: Point(latitude: 1, longitude: 1),
  imagePath: TEST_IMAGE_PATH,
);

final testQuestion = QuestionModel(
  question: 'question',
  answers: null,
);

final testUser = User;
