import 'package:flutter/foundation.dart';

import '../domain/models/info_cards_model.dart';
import '../domain/repository/info_cards_repository.dart';

class AdmissionInfoProvider with ChangeNotifier {
  final InfoCardsRepository infoCardsRepository;

  List<InfoCard> infoCards = [];
  bool get isInfoCardsLoaded => infoCards.isNotEmpty;

  AdmissionInfoProvider({required this.infoCardsRepository}) {
    initInfoCards();
  }

  void initInfoCards() async {
    infoCards = await infoCardsRepository.getCards();
    notifyListeners();
  }

  void addInfoCard(String title, String subtitle) {
    infoCardsRepository
        .addCard(title, subtitle)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void editInfoCard(String title, String subtitle, String id) {
    infoCardsRepository
        .editCard(title, subtitle, id)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void removeInfoCard(String id) {
    infoCardsRepository.removeCard(id).whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void moveUpInfoCard(String currId, String prevId) {
    infoCardsRepository
        .moveUp(currId, prevId)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }

  void moveDownInfoCard(String currId, String nextId) {
    infoCardsRepository
        .moveDown(currId, nextId)
        .whenComplete(() => initInfoCards());
    notifyListeners();
  }
}
