import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Data {
  // Map data
  static Point initialPoint = Point(
    latitude: 53.922288,
    longitude: 27.593033,
  );

  Color mainColor = Color.fromARGB(255, 0, 138, 94);

  String? currentAdmissionYear;

  Data({this.currentAdmissionYear});

  final dbRef = FirebaseFirestore.instance.collection('settings');

  final dbErrorRef = FirebaseFirestore.instance.collection('errorMessages');

  void editSettings(String currentAdmissionYear, String key) async {
    await dbRef.doc('commonSettings').update({
      'currentAdmissionYear': currentAdmissionYear,
      'secretKey': key,
    });
  }

  Future<String> getCurrentAdmissionYear() async {
    String year = await dbRef.doc('commonSettings').get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'currentAdmissionYear') _toReturn = item.value;
      }
      return _toReturn;
    });
    return year;
  }

  Future<String> getFieldData(String fieldName) async {
    String year = await dbRef.doc('commonSettings').get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == fieldName) _toReturn = item.value;
      }
      return _toReturn;
    });
    return year;
  }
}
