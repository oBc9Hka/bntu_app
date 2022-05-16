import 'dart:async';

import 'package:bntu_app/features/map/domain/models/buildings_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../domain/repository/buildings_repository.dart';

class BuildingsFirestoreRepository extends BuildingsRepository {
  final dbRef = FirebaseFirestore.instance.collection('buildings');

  @override
  Future<void> addBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
  ) async {
    var newOrderId = 0;
    var item = await dbRef.get();
    newOrderId = item.docs.length + 1;

    await dbRef.add({
      'name': name,
      'description': description,
      'optional': optional,
      'point': GeoPoint(point.latitude, point.longitude),
      'imagePath': imagePath,
      'orderId': newOrderId,
    });
  }

  @override
  Future<void> editBuilding(
    String name,
    String description,
    String optional,
    Point point,
    String imagePath,
    String id,
  ) async {
    await dbRef.doc(id).update({
      'name': name,
      'description': description,
      'optional': optional,
      'point': GeoPoint(point.latitude, point.longitude),
      'imagePath': imagePath,
    });
  }

  @override
  Future<List<Building>> getBuildingsList() async {
    var list = <Building>[];
    var temp = await dbRef.get();

    if (temp.docs.isEmpty) {
      throw TimeoutException('Ошибка соединения');
    }

    for (var faculty in temp.docs) {
      list.add(Building.fromMap(faculty.data(), faculty.id));
    }

    list.sort((a, b) => a.orderId!.compareTo(b.orderId!));

    return list;
  }

  @override
  Future<void> moveDown(String currId, String nextId) async {
    var currOrderId = await dbRef.doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    var nextOrderId = currOrderId + 1;

    await dbRef.doc(currId).update({
      'orderId': nextOrderId,
    });
    await dbRef.doc(nextId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> moveUp(String currId, String prevId) async {
    var currOrderId = await dbRef.doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    var prevOrderId = currOrderId - 1;

    await dbRef.doc(currId).update({
      'orderId': prevOrderId,
    });
    await dbRef.doc(prevId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> removeBuilding(String id) async {
    await dbRef.doc(id).delete();
  }
}
