import 'package:bntu_app/core/domain/models/error_message_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  final String _quizFacultiesCollection = 'quiz';
  final String _quizSpecialtiesCollection = 'quizSpecialties';

  // final FacultiesRepository _facultiesRepository;
  // final SpecialtiesRepository _specialtiesRepository;
  // final SettingsRepository _settingsRepository;
  // final InfoCardsRepository _infoCardsRepository;

  // final ErrorMessagesRepository _errorMessagesRepository;

  // final BuildingsRepository _buildingsRepository;
  final QuestionsRepository _questionsRepository;

  User? user;
  Map<String, dynamic> errorsMap = {};

  List<ErrorMessage> errorMessages = [];

  bool get isErrorMessagesLoaded => errorMessages.isNotEmpty;

  List<QuestionModel> facultiesQuestions = [];

  bool get isFacultiesQuestionsLoaded => facultiesQuestions.isNotEmpty;

  List<QuestionModel> specialtiesQuestions = [];

  bool get isSpecialtiesQuestionsLoaded => specialtiesQuestions.isNotEmpty;

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

  AppProvider(
    // this._facultiesRepository,
    // this._specialtiesRepository,
    // this._settingsRepository,
    // this._infoCardsRepository,
    // this._errorMessagesRepository,
    // this._buildingsRepository,
    this._questionsRepository,
    // this._userRepository,
  ) {
    // initUser();
    // initFaculties();
    // initSpecialties();
    // initSettings();
    // initInfoCards();
    // initErrorMessages();
    // initBuildings();
    initQuestions();
  }

  void initQuestions() async {
    facultiesQuestions = await _questionsRepository.getQuestionsList('quiz');
    specialtiesQuestions =
        await _questionsRepository.getQuestionsList('quizSpecialties');
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
