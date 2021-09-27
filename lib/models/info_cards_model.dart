import 'package:cloud_firestore/cloud_firestore.dart';

class InfoCard {
  String? title;
  String? subtitle;
  int? orderId;

  InfoCard({this.title, this.subtitle, this.orderId});

  final dbRef = FirebaseFirestore.instance;

  void addCard(String title, String subtitle) async {
    int newOrderId = 0;
    QuerySnapshot<Map<String, dynamic>> item = await dbRef.collection('infoCards').get();
    newOrderId = item.docs.length + 1;

    await dbRef.collection('infoCards').add({
      'title': title,
      'subtitle': subtitle,
      'orderId': newOrderId,
    });
  }

  void editCard(String title, String subtitle, String id) async {
    await dbRef.collection('infoCards').doc(id).update({
      'title': title,
      'subtitle': subtitle,
    });
  }

  void removeCard(String id) async {
    await dbRef.collection('infoCards').doc(id).delete();
  }


  void moveUp(String currId, String prevId) async {
    int currOrderId = await dbRef.collection('infoCards').doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    int prevOrderId = currOrderId - 1;

    await dbRef.collection('infoCards').doc(currId).update({
      'orderId': prevOrderId,
    });
    await dbRef.collection('infoCards').doc(prevId).update({
      'orderId': currOrderId,
    });
  }

  void moveDown(String currId, String nextId) async {
    int currOrderId = await dbRef.collection('infoCards').doc(currId).get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'orderId') _toReturn = item.value;
      }
      return _toReturn;
    });
    int nextOrderId = currOrderId + 1;

    await dbRef.collection('infoCards').doc(currId).update({
      'orderId': nextOrderId,
    });
    await dbRef.collection('infoCards').doc(nextId).update({
      'orderId': currOrderId,
    });
  }
}
