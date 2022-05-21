import '../models/info_cards_model.dart';

abstract class InfoCardsRepository {
  Future<List<InfoCard>> getCards();

  Future<void> addCard(String title, String subtitle);

  Future<void> editCard(String title, String subtitle, String id);

  Future<void> removeCard(String id);

  Future<void> moveUp(String currId, String prevId);

  Future<void> moveDown(String currId, String nextId);
}
