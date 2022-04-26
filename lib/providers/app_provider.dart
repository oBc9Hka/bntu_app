import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/features/greetings/domain/models/error_message_model.dart';
import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AppProvider with ChangeNotifier {
  final String _quizFacultiesCollection = 'quiz';
  final String _quizSpecialtiesCollection = 'quizSpecialties';

  // final FacultiesRepository _facultiesRepository;
  // final SpecialtiesRepository _specialtiesRepository;
  final SettingsRepository _settingsRepository;
  final InfoCardsRepository _infoCardsRepository;

  // final ErrorMessagesRepository _errorMessagesRepository;

  final BuildingsRepository _buildingsRepository;
  final QuestionsRepository _questionsRepository;

  User? user;
  Map<String, dynamic> errorsMap = {};

  List<InfoCard> infoCards = [];

  bool get isInfoCardsLoaded => infoCards.isNotEmpty;

  List<ErrorMessage> errorMessages = [];

  bool get isErrorMessagesLoaded => errorMessages.isNotEmpty;

  List<Building> buildings = [];

  bool get isBuildingsLoaded => buildings.isNotEmpty;

  List<QuestionModel> facultiesQuestions = [];

  bool get isFacultiesQuestionsLoaded => facultiesQuestions.isNotEmpty;

  List<QuestionModel> specialtiesQuestions = [];

  bool get isSpecialtiesQuestionsLoaded => specialtiesQuestions.isNotEmpty;

  String currentAdmissionYear = '';
  String secretKey = '';
  String unseenCount = '';

  String dropdown1Value = '...';
  String dropdown2Value = '...';
  String dropdown3Value = '...';
  String dropdown4Value = '...';
  String dropdown5Value = '...';

  String dropdown12Value = '...';
  String dropdown22Value = '...';
  String dropdown32Value = '...';
  String dropdown42Value = '...';
  String dropdown52Value = '...';

  bool isFacultiesQuiz = true; // Quiz for faculties or specialties

  AppProvider(
    // this._facultiesRepository,
    // this._specialtiesRepository,
    this._settingsRepository,
    this._infoCardsRepository,
    // this._errorMessagesRepository,
    this._buildingsRepository,
    this._questionsRepository,
    // this._userRepository,
  ) {
    // initUser();
    // initFaculties();
    // initSpecialties();
    initSettings();
    initInfoCards();
    // initErrorMessages();
    initBuildings();
    initQuestions();
  }

  // void initFaculties() async {
  //   faculties = await _facultiesRepository.getFacultiesList();
  //   facultiesShortNames = await _facultiesRepository.getFacultiesShortNames();
  //   notifyListeners();
  // }

  void initSettings() async {
    currentAdmissionYear = await _settingsRepository.getCurrentAdmissionYear();
    secretKey = await _settingsRepository.getSecretKey();
    isFacultiesQuiz = await _settingsRepository.getIsFacultyQuizChecked();
    notifyListeners();
  }

  void initInfoCards() async {
    infoCards = await _infoCardsRepository.getCards();
    notifyListeners();
  }

  void initBuildings() async {
    buildings = await _buildingsRepository.getBuildingsList();
    notifyListeners();
  }

  void initQuestions() async {
    facultiesQuestions = await _questionsRepository.getQuestionsList('quiz');
    specialtiesQuestions =
        await _questionsRepository.getQuestionsList('quizSpecialties');
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

  void editQuizChecked(bool isFacultiesQuiz) {
    _settingsRepository
        .editQuizChecked(isFacultiesQuiz)
        .whenComplete(() => initSettings());
    notifyListeners();
  }

  // void changeViewedState(String id) {
  //   errorMessagesRepository
  //       .changeViewedState(id)
  //       .whenComplete(() => initErrorMessages());
  //   notifyListeners();
  // }

  // void removeErrorMessage(String id) {
  //   errorMessagesRepository
  //       .removeErrorMessage(id)
  //       .whenComplete(() => initErrorMessages());
  //   notifyListeners();
  // }

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

  void addFacultyQuestion(
    String question,
    List<Map<String, dynamic>> answers,
  ) {
    _questionsRepository
        .addQuestion(_quizFacultiesCollection, question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void editFacultyQuestion(
    String id,
    String question,
    List<Map<String, dynamic>> answers,
  ) {
    _questionsRepository
        .editQuestion(_quizFacultiesCollection, id, question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void removeFacultyQuestion(String id) {
    _questionsRepository
        .removeQuestion(_quizFacultiesCollection, id)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveUpFacultyQuestion(String currId, String prevId) {
    _questionsRepository
        .moveUp(_quizFacultiesCollection, currId, prevId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveDownFacultyQuestion(String currId, String nextId) {
    _questionsRepository
        .moveDown(_quizFacultiesCollection, currId, nextId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void addSpecialityQuestion(
    String question,
    List<Map<String, dynamic>> answers,
  ) {
    _questionsRepository
        .addQuestion(_quizSpecialtiesCollection, question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void editSpecialityQuestion(
    String id,
    String question,
    List<Map<String, dynamic>> answers,
  ) {
    _questionsRepository
        .editQuestion(_quizSpecialtiesCollection, id, question, answers)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void removeSpecialityQuestion(String id) {
    _questionsRepository
        .removeQuestion(_quizSpecialtiesCollection, id)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveUpSpecialityQuestion(String currId, String prevId) {
    _questionsRepository
        .moveUp(_quizSpecialtiesCollection, currId, prevId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }

  void moveDownSpecialityQuestion(String currId, String nextId) {
    _questionsRepository
        .moveDown(_quizSpecialtiesCollection, currId, nextId)
        .whenComplete(() => initQuestions());
    notifyListeners();
  }
}
