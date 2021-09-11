import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class InfoCard {
  String? title;
  String? subtitle;
  int? orderId;

  InfoCard({this.title, this.subtitle, this.orderId});

  final dbRef = FirebaseFirestore.instance;

  void getNewOrderId() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await dbRef.collection('infoCards').orderBy('orderId').snapshots().last;
    print(snapshot.docs[0].get('title'));
    
    // StreamBuilder(
    //   stream: dbRef.collection('infoCards').orderBy('orderId').snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     print(snapshot.data!.docs[0].get('title'));
    //     return Container();
    //   },
    // );
  }

  void addCard(String title, String subtitle, int orderId) async {
    await dbRef.collection('infoCards').add({
      'title': title,
      'subtitle': subtitle,
      'orderId': orderId,
    });
  }

  void editCard(String title, String subtitle, int orderId, String id) async {
    await dbRef.collection('infoCards').doc(id).update({
      'title': title,
      'subtitle': subtitle,
      'orderId': orderId,
    });
  }

  void removeCard(String id) async {
    await dbRef.collection('infoCards').doc(id).delete();
  }
}
