import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? id;
  int? orderId;
  String? question;
  Map<String, dynamic>? answers;

  QuestionModel({this.id, this.orderId, this.question, this.answers});

  final dbRef = FirebaseFirestore.instance.collection('quiz');

  Future<int> getLength() async {
    return await dbRef.get().then((snapshot) {
      List<int> _temp = [];
      snapshot.docs.forEach((e) {
        _temp.add(e.get('orderId'));
      });
      int max = 0;
      _temp.forEach((element) {
        if(element > max) {
          max = element;
        }
      });
      return ++max;
    });
  }

  void addQuestion(String question, Map<String, dynamic> answers) async {
    int newOrderId = await getLength();
    await dbRef.add({
      'question': question,
      'answers': answers,
      'orderId': newOrderId,
    });
  }

  void editQuestion(String id, String question, Map<String, dynamic> answers) async {
    await dbRef.doc(id).update({
      'question': question,
      'answers': answers,
    });
  }

  void removeQuestion(String id){
    dbRef.doc(id).delete();
  }

  void moveUp(String currId, String prevId) async {
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

  void moveDown(String currId, String nextId) async {
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
}
