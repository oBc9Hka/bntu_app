import 'package:flutter/foundation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../domain/models/buildings_model.dart';
import '../domain/repository/buildings_repository.dart';

class MapProvider with ChangeNotifier {
  final BuildingsRepository buildingsRepository;
  MapProvider({required this.buildingsRepository}) {
    initBuildings();
  }

  List<Building> buildings = [];
  bool get isBuildingsLoaded => buildings.isNotEmpty;

  void initBuildings() async {
    buildings = await buildingsRepository.getBuildingsList();
    notifyListeners();
  }

  void addBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
  ) {
    buildingsRepository
        .addBuilding(
          name,
          description,
          optional,
          point,
          imagePath,
        )
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void editBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
    String id,
  ) {
    buildingsRepository
        .editBuilding(
          name,
          description,
          optional,
          point,
          imagePath,
          id,
        )
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void removeBuilding(String id) {
    buildingsRepository.removeBuilding(id).whenComplete(() => initBuildings());
    notifyListeners();
  }

  void moveUpBuilding(String currId, String prevId) {
    buildingsRepository
        .moveUp(currId, prevId)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }

  void moveDownBuilding(String currId, String nextId) {
    buildingsRepository
        .moveDown(currId, nextId)
        .whenComplete(() => initBuildings());
    notifyListeners();
  }
}
