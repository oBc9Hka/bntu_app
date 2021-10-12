import 'dart:async';

import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsFirestoreRepository extends QuestionsRepository {
  final dbRef = FirebaseFirestore.instance.collection('quiz');

  @override
  Future<void> addQuestion(
      String question, Map<String, dynamic> answers) async {
    int newOrderId = await _getLength();
    await dbRef.add({
      'question': question,
      'answers': answers,
      'orderId': newOrderId,
    });
  }

  @override
  Future<void> editQuestion(
      String id, String question, Map<String, dynamic> answers) async {
    await dbRef.doc(id).update({
      'question': question,
      'answers': answers,
    });
  }

  @override
  Future<List<QuestionModel>> getQuestionsList() async {
    List<QuestionModel> list = [];
    QuerySnapshot<Map<String, dynamic>> temp = await dbRef.get();

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
  Future<void> removeQuestion(String id) async {
    await dbRef.doc(id).delete();
  }

  Future<int> _getLength() async {
    return await dbRef.get().then((snapshot) {
      List<int> _temp = [];
      snapshot.docs.forEach((e) {
        _temp.add(e.get('orderId'));
      });
      int max = 0;
      _temp.forEach((element) {
        if (element > max) {
          max = element;
        }
      });
      return ++max;
    });
  }
}
