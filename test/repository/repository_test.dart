import 'package:bntu_app/repository/buildings_repository.dart';
import 'package:bntu_app/features/greetings/repository/error_messages_repository.dart';
import 'package:bntu_app/features/faculties/repository/faculties_repository.dart';
import 'package:bntu_app/repository/info_cards_repository.dart';
import 'package:bntu_app/repository/questions_repository.dart';
import 'package:bntu_app/repository/settings_repository.dart';
import 'package:bntu_app/features/specialties/repository/specialties_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../consts.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FacultiesFirestoreRepository>(
    as: #BaseMockFacultiesFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<SpecialtiesFirestoreRepository>(
    as: #BaseMockSpecialtiesFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<SettingsFirestoreRepository>(
    as: #BaseMockSettingsFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<InfoCardsFirestoreRepository>(
    as: #BaseMockInfoCardsFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<ErrorMessagesFirestoreRepository>(
    as: #BaseMockErrorMessagesFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<BuildingsFirestoreRepository>(
    as: #BaseMockBuildingsFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
  MockSpec<QuestionsFirestoreRepository>(
    as: #BaseMockQuestionsFirestoreRepository,
    returnNullOnMissingStub: true,
  )
])
void main() async {
  BaseMockFacultiesFirestoreRepository _facultiesMockRepository =
      BaseMockFacultiesFirestoreRepository();
  BaseMockSpecialtiesFirestoreRepository _specialtiesMockRepository =
      BaseMockSpecialtiesFirestoreRepository();

  BaseMockSettingsFirestoreRepository _settingsMockRepository =
      BaseMockSettingsFirestoreRepository();
  BaseMockInfoCardsFirestoreRepository _infoCardsMockRepository =
      BaseMockInfoCardsFirestoreRepository();
  BaseMockErrorMessagesFirestoreRepository _errorMessagesMockRepository =
      BaseMockErrorMessagesFirestoreRepository();
  BaseMockBuildingsFirestoreRepository _buildingsMockRepository =
      BaseMockBuildingsFirestoreRepository();
  // BaseMockQuestionsFirestoreRepository _questionsMockRepository =
  //     BaseMockQuestionsFirestoreRepository();
  List _list;

  setUp(() {
    _list = [];
  });

  group('Faculties', () {
    test('Faculties list loading', () async {
      when(_facultiesMockRepository.getFacultiesList())
          .thenAnswer((realInvocation) => Future.value([]));

      _list = await _facultiesMockRepository.getFacultiesList();
      expect(_list.length, 0);
    });

    test('Faculties list add', () async {
      when(_facultiesMockRepository.getFacultiesList())
          .thenAnswer((realInvocation) => Future.value([testFaculty]));

      await _facultiesMockRepository.addFaculty(
          'name',
          'shortName',
          'about',
          'hotLineNumber',
          'hotLineMail',
          'forInquiriesNumber',
          'forHostelNumber',
          'imagePath');
      _list = await _facultiesMockRepository.getFacultiesList();
      expect(_list.length, 1);
      expect(_list, [testFaculty]);
    });
  });

  group('Specialties', () {
    test('Specialties list loading', () async {
      when(_specialtiesMockRepository.getSpecialtiesList())
          .thenAnswer((realInvocation) => Future.value([]));

      _list = await _specialtiesMockRepository.getSpecialtiesList();
      expect(_list.length, 0);
    });

    test('Specialties list add', () async {
      when(_specialtiesMockRepository.getSpecialtiesList())
          .thenAnswer((realInvocation) => Future.value([testSpeciality]));

      await _specialtiesMockRepository.addSpeciality(
        testSpeciality.facultyBased,
        testSpeciality.name,
        testSpeciality.number,
        testSpeciality.about,
        testSpeciality.qualification,
        testSpeciality.trainingDurationDayFull,
        testSpeciality.trainingDurationDayShort,
        testSpeciality.trainingDurationCorrespondenceFull,
        testSpeciality.trainingDurationCorrespondenceShort,
        [],
        [],
        testSpeciality.admissionCurrentDayFullBudget,
        testSpeciality.admissionCurrentDayShortBudget,
        testSpeciality.admissionCurrentDayFullPaid,
        testSpeciality.admissionCurrentDayShortPaid,
        testSpeciality.admissionCurrentCorrespondenceFullBudget,
        testSpeciality.admissionCurrentCorrespondenceShortBudget,
        testSpeciality.admissionCurrentCorrespondenceFullPaid,
        testSpeciality.admissionCurrentCorrespondenceShortPaid,
        testSpeciality.passScorePrevYearDayFullBudget,
        testSpeciality.passScorePrevYearDayShortBudget,
        testSpeciality.passScorePrevYearDayFullPaid,
        testSpeciality.passScorePrevYearDayShortPaid,
        testSpeciality.passScorePrevYearCorrespondenceFullBudget,
        testSpeciality.passScorePrevYearCorrespondenceShortBudget,
        testSpeciality.passScorePrevYearCorrespondenceFullPaid,
        testSpeciality.passScorePrevYearCorrespondenceShortPaid,
        testSpeciality.admissionPrevYearDayFullBudget,
        testSpeciality.admissionPrevYearDayShortBudget,
        testSpeciality.admissionPrevYearDayFullPaid,
        testSpeciality.admissionPrevYearDayShortPaid,
        testSpeciality.admissionPrevYearCorrespondenceFullBudget,
        testSpeciality.admissionPrevYearCorrespondenceShortBudget,
        testSpeciality.admissionPrevYearCorrespondenceFullPaid,
        testSpeciality.admissionPrevYearCorrespondenceShortPaid,
        testSpeciality.passScoreBeforeLastYearDayFullBudget,
        testSpeciality.passScoreBeforeLastYearDayShortBudget,
        testSpeciality.passScoreBeforeLastYearDayFullPaid,
        testSpeciality.passScoreBeforeLastYearDayShortPaid,
        testSpeciality.passScoreBeforeLastYearCorrespondenceFullBudget,
        testSpeciality.passScoreBeforeLastYearCorrespondenceShortBudget,
        testSpeciality.passScoreBeforeLastYearCorrespondenceFullPaid,
        testSpeciality.passScoreBeforeLastYearCorrespondenceShortPaid,
      );
      _list = await _specialtiesMockRepository.getSpecialtiesList();
      expect(_list.length, 1);
      expect(_list, [testSpeciality]);
    });
  });

  group('InfoCards', () {
    test('InfoCards list loading', () async {
      when(_infoCardsMockRepository.getCards())
          .thenAnswer((realInvocation) => Future.value([]));

      _list = await _infoCardsMockRepository.getCards();
      expect(_list.length, 0);
    });

    test('InfoCards list add', () async {
      when(_infoCardsMockRepository.getCards())
          .thenAnswer((realInvocation) => Future.value([testInfoCard]));

      await _infoCardsMockRepository.addCard(
          testInfoCard.title, testInfoCard.subtitle);
      _list = await _infoCardsMockRepository.getCards();
      expect(_list.length, 1);
      expect(_list, [testInfoCard]);
    });
  });

  group('ErrorMessages', () {
    test('Error messages list loading', () async {
      when(_errorMessagesMockRepository.getErrorMessagesList())
          .thenAnswer((realInvocation) => Future.value([]));

      _list = await _errorMessagesMockRepository.getErrorMessagesList();
      expect(_list.length, 0);
    });

    test('Error messages list add', () async {
      when(_errorMessagesMockRepository.getErrorMessagesList())
          .thenAnswer((realInvocation) => Future.value([testErrorMessage]));

      await _errorMessagesMockRepository
          .submitErrorMessage(testErrorMessage.message);
      _list = await _errorMessagesMockRepository.getErrorMessagesList();
      expect(_list.length, 1);
      expect(_list, [testErrorMessage]);
    });
  });

  group('Settings', () {
    test('Get secret key test', () async {
      when(_settingsMockRepository.getSecretKey())
          .thenAnswer((realInvocation) => Future.value('Admin'));
      String answer = await _settingsMockRepository.getSecretKey();
      expect(answer, 'Admin');
    });

    test('Get current year test', () async {
      when(_settingsMockRepository.getCurrentAdmissionYear())
          .thenAnswer((realInvocation) => Future.value('2021'));
      String answer = await _settingsMockRepository.getCurrentAdmissionYear();
      expect(answer, '2021');
    });
  });

  group('Buildings', () {
    test('Buildings list loading', () async {
      when(_buildingsMockRepository.getBuildingsList())
          .thenAnswer((realInvocation) => Future.value([]));

      _list = await _buildingsMockRepository.getBuildingsList();
      expect(_list.length, 0);
    });

    test('Error messages list add', () async {
      when(_buildingsMockRepository.getBuildingsList())
          .thenAnswer((realInvocation) => Future.value([testBuilding]));
      await _buildingsMockRepository.addBuilding(
        testBuilding.name,
        testBuilding.optional,
        testBuilding.point,
        testBuilding.imagePath,
      );
      _list = await _buildingsMockRepository.getBuildingsList();
      expect(_list.length, 1);
      expect(_list, [testBuilding]);
    });
  });

  // group('Questions', () {
  //   test('Error messages list loading', () async {
  //     when(_questionsMockRepository.getQuestionsList())
  //         .thenAnswer((realInvocation) => Future.value([]));
  //
  //     _list = await _questionsMockRepository.getQuestionsList();
  //     expect(_list.length, 0);
  //   });
  //
  //   test('Error messages list add', () async {
  //     when(_questionsMockRepository.getQuestionsList())
  //         .thenAnswer((realInvocation) => Future.value([testQuestion]));
  //
  //     await _questionsMockRepository.addQuestion(
  //         testQuestion.question, testQuestion.answers);
  //     _list = await _questionsMockRepository.getQuestionsList();
  //     expect(_list.length, 1);
  //     expect(_list, [testQuestion]);
  //   });
  // });
}
