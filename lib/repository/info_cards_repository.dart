import 'dart:async';

import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoCardsFirestoreRepository extends InfoCardsRepository{
  final dbRef = FirebaseFirestore.instance.collection('infoCards');

  @override
  Future<void> addCard(String title, String subtitle) async {
    int newOrderId = 0;
    QuerySnapshot<Map<String, dynamic>> item = await dbRef.get();
    newOrderId = item.docs.length + 1;

    await dbRef.add({
      'title': title,
      'subtitle': subtitle,
      'orderId': newOrderId,
    });
  }

  @override
  Future<void> editCard(String title, String subtitle, String id) async {
    await dbRef.doc(id).update({
      'title': title,
      'subtitle': subtitle,
    });
  }

  @override
  Future<List<InfoCard>> getCards() async {
    List<InfoCard> list = [];
    QuerySnapshot<Map<String, dynamic>> temp = await dbRef.get();

    if(temp.docs.isEmpty){
      throw TimeoutException('Ошибка соединения');
    }

    for (var faculty in temp.docs){
      list.add(InfoCard.fromMap(faculty.data(), faculty.id));
    }

    list.sort((a, b) => a.orderId!.compareTo(b.orderId!));

    return list;
  }

  @override
  Future<void> moveUp(String currId, String prevId) async {
    int currOrderId = await dbRef.doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    int prevOrderId = currOrderId - 1;

    await dbRef.doc(currId).update({
      'orderId': prevOrderId,
    });
    await dbRef.doc(prevId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> moveDown(String currId, String nextId) async {
    int currOrderId = await dbRef.doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    int nextOrderId = currOrderId + 1;

    await dbRef.doc(currId).update({
      'orderId': nextOrderId,
    });
    await dbRef.doc(nextId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> removeCard(String id) async {
    await dbRef.doc(id).delete();
  }

}