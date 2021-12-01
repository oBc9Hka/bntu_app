import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/models/error_message_model.dart';
import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AppProvider with ChangeNotifier {
  final UserRepository _userRepository;

  final FacultiesRepository _facultiesRepository;
  final SpecialtiesRepository _specialtiesRepository;
  final SettingsRepository _settingsRepository;
  final InfoCardsRepository _infoCardsRepository;
  final ErrorMessagesRepository _errorMessagesRepository;
  final BuildingsRepository _buildingsRepository;
  final QuestionsRepository _questionsRepository;

  User? user;
  Map<String, dynamic> errorsMap = {};

  List<Faculty> faculties = [];
  List<String> facultiesShortNames = [];

  bool get isFacultiesLoaded => faculties.isNotEmpty;

  List<Speciality> specialties = [];

  bool get isSpecialtiesLoaded => specialties.isNotEmpty;

  List<InfoCard> infoCards = [];

  bool get isInfoCardsLoaded => infoCards.isNotEmpty;

  List<ErrorMessage> errorMessages = [];

  bool get isErrorMessagesLoaded => errorMessages.isNotEmpty;

  List<Building> buildings = [];

  bool get isBuildingsLoaded => buildings.isNotEmpty;

  List<QuestionModel> questions = [];

  bool get isQuestionsLoaded => questions.isNotEmpty;

  String currentAdmissionYear = '';
  String secretKey = '';
  String unseenCount = '';

  String dropdown1Value = '...';
  String dropdown2Value = '...';
  String dropdown3Value = '...';
  String dropdown4Value = '...';
  String dropdown5Value = '...';

  bool isList = true; // ListView or GridView at faculties page

  AppProvider(
    this._facultiesRepository,
    this._specialtiesRepository,
    this._settingsRepository,
    this._infoCardsRepository,
    this._errorMessagesRepository,
    this._buildingsRepository,
    this._questionsRepository,
    this._userRepository,
  ) {
    initUser();
    initFaculties();
    initSpecialties();
    initSettings();
    initInfoCards();
    initErrorMessages();
    initBuildings();
    initQuestions();
  }

  void initUser() async {
    user = await _userRepository
        .getCurrentUser()
        .whenComplete(() => initErrorsMap());

    notifyListeners();
  }

  void initFaculties() async {
    faculties = await _facultiesRepository.getFacultiesList();
    facultiesShortNames = await _facultiesRepository.getFacultiesShortNames();
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

  void initInfoCards() async {
    infoCards = await _infoCardsRepository.getCards();
    notifyListeners();
  }

  void initErrorMessages() async {
    errorMessages = await _errorMessagesRepository.getErrorMessagesList();
    unseenCount = await _errorMessagesRepository.getUnseenMessages();
    notifyListeners();
  }

  void initBuildings() async {
    buildings = await _buildingsRepository.getBuildingsList();
    notifyListeners();
  }

  void initQuestions() async {
    questions = await _questionsRepository.getQuestionsList();
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
    notifyListeners();
  }

  void removeFaculty(String id, String packageName) {
    _facultiesRepository.removeFaculty(id, packageName);
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
    notifyListeners();
  }

  void removeSpeciality(String id) {
    _specialtiesRepository.removeSpeciality(id);
    notifyListeners();
  }

  void addInfoCard(String title, String subtitle) {
    _infoCardsRepository
        .addCard(title, subtitle)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void editInfoCard(String title, String subtitle, String id) {
    _infoCardsRepository
        .editCard(title, subtitle, id)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void removeInfoCard(String id) {
    _infoCardsRepository.removeCard(id).whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void moveUpInfoCard(String currId, String prevId) {
    _infoCardsRepository
        .moveUp(currId, prevId)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void moveDownInfoCard(String currId, String nextId) {
    _infoCardsRepository
        .moveDown(currId, nextId)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void editSettings(String currentAdmissionYear, String key) {
    _settingsRepository
        .editSettings(currentAdmissionYear, key)
        .whenComplete(() => initSettings());
    notifyListeners();
  }

  void submitErrorMessage(String msg) {
    _errorMessagesRepository
        .submitErrorMessage(msg)
        .whenComplete(() => initErrorMessages());
    notifyListeners();
  }

  void changeViewedState(String id) {
    _errorMessagesRepository
        .changeViewedState(id)
        .whenComplete(() => initErrorMessages());
    notifyListeners();
  }

  void removeErrorMessage(String id) {
    _errorMessagesRepository
        .removeErrorMessage(id)
        .whenComplete(() => initErrorMessages());
    notifyListeners();
  }

  void addBuilding(
      String name, String optional, Point point, String imagePath) {
    _buildingsRepository
        .addBuilding(name, optional, point, imagePath)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void editBuilding(
      String name, String optional, Point point, String imagePath, String id) {
    _buildingsRepository
        .editBuilding(name, optional, point, imagePath, id)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void removeBuilding(String id) {
    _buildingsRepository.removeBuilding(id).whenComplete(() => initBuildings());
    notifyListeners();
  }

  void moveUpBuilding(String currId, String prevId) {
    _buildingsRepository
        .moveUp(currId, prevId)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void moveDownBuilding(String currId, String nextId) {
    _buildingsRepository
        .moveDown(currId, nextId)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void addQuestion(String question, Map<String, dynamic> answers) {
    _questionsRepository
        .addQuestion(question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void editQuestion(
    String id,
    String question,
    Map<String, dynamic> answers,
  ) {
    _questionsRepository
        .editQuestion(id, question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void removeQuestion(String id) {
    _questionsRepository.removeQuestion(id).whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveUpQuestion(String currId, String prevId) {
    _questionsRepository
        .moveUp(currId, prevId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveDownQuestion(String currId, String nextId) {
    _questionsRepository
        .moveDown(currId, nextId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void signUp(String email, String password) {
    _userRepository.signUp(email, password).whenComplete(() => initUser());
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async{
    await _userRepository
        .signIn(email, password)
        .whenComplete(() {
      initUser();
      initErrorsMap();
    });
    notifyListeners();
  }

  void signOut() {
    _userRepository.signOut().whenComplete(() => initUser());
    notifyListeners();
  }

  void initErrorsMap() {
    errorsMap = _userRepository.getErrors();
    notifyListeners();
  }
}
