import 'package:bntu_app/models/buildings_model.dart';
import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
