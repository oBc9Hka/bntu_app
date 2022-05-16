import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/buildings_model.dart';

abstract class BuildingsRepository {
  Future<List<Building>> getBuildingsList();

  Future<void> addBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
  );

  Future<void> editBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
    String id,
  );

  Future<void> removeBuilding(String id);

  Future<void> moveUp(String currId, String prevId);

  Future<void> moveDown(String currId, String nextId);
}
