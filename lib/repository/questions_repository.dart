import 'dart:async';

import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsFirestoreRepository extends QuestionsRepository {
  final dbRef = FirebaseFirestore.instance;

  @override
  Future<void> addQuestion(String collection, String question,
      List<Map<String, dynamic>> answers) async {
    var newOrderId = await _getLength(collection);
    await dbRef.collection(collection).add({
      'question': question,
      'answers': answers,
      'orderId': newOrderId,
    });
  }

  @override
  Future<void> editQuestion(String collection, String id, String question,
      List<Map<String, dynamic>> answers) async {
    await dbRef.collection(collection).doc(id).update({
      'question': question,
      'answers': answers,
    });
  }

  @override
  Future<List<QuestionModel>> getQuestionsList(String collection) async {
    var list = <QuestionModel>[];
    var temp = await dbRef.collection(collection).get();

    if (temp.docs.isEmpty) {
      throw TimeoutException('Ошибка соединения');
    }

    for (var faculty in temp.docs) {
      list.add(QuestionModel.fromMap(faculty.data(), faculty.id));
    }

    list.sort((a, b) => a.orderId!.compareTo(b.orderId!));

    return list;
  }

  @override
  Future<void> moveDown(String collection, String currId, String nextId) async {
    var currOrderId =
        await dbRef.collection(collection).doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    var nextOrderId = currOrderId + 1;

    await dbRef.collection(collection).doc(currId).update({
      'orderId': nextOrderId,
    });
    await dbRef.collection(collection).doc(nextId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> moveUp(String collection, String currId, String prevId) async {
    var currOrderId =
        await dbRef.collection(collection).doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    var prevOrderId = currOrderId - 1;

    await dbRef.collection(collection).doc(currId).update({
      'orderId': prevOrderId,
    });
    await dbRef.collection(collection).doc(prevId).update({
      'orderId': currOrderId,
    });
  }

  @override
  Future<void> removeQuestion(String collection, String id) async {
    await dbRef.collection(collection).doc(id).delete();
  }

  Future<int> _getLength(String collection) async {
    return await dbRef.collection(collection).get().then((snapshot) {
      var _temp = <int>[];
      snapshot.docs.forEach((e) {
        _temp.add(e.get('orderId'));
      });
      var max = 0;
      _temp.forEach((element) {
        if (element > max) {
          max = element;
        }
      });
      return ++max;
    });
  }
}
