import 'package:bntu_app/models/question_model.dart';
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
  String unexpectedError = 'Произошла нерпедвиденная ошибка';
  String timeOutError =
      'Ошибка соединения, пожалуйста, проверьте своё подключение к интернету';

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

  final dbQuizRef = FirebaseFirestore.instance.collection('quiz');

  Future<List<QuestionModel>> initQuestions() async {
    List<QuestionModel> questions = [];
    try {
      QuerySnapshot<Map<String, dynamic>> temp = await dbQuizRef.get();
      if(temp.docs.isEmpty){
        throw timeOutError;
      }
      for (var item in temp.docs) {
        String id = item.id;
        int orderId = item['orderId'];
        String question = item['question'];
        Map<String, dynamic> answers = item['answers'];
        questions.add(QuestionModel(
            id: id, orderId: orderId, question: question, answers: answers));
      }
      questions.sort((a, b) => a.orderId!.compareTo(b.orderId!));
      return questions;
    } catch (e) {
      throw e.toString();
    }
  }

  final dbRefUniversal = FirebaseFirestore.instance;

  Future<List<String>> getFacultiesShortNames() async {
    List<String> shortNames = [];
    QuerySnapshot<Map<String, dynamic>> temp =
        await dbRefUniversal.collection('faculties').get();
    for (var item in temp.docs) {
      String shortName = item['shortName'];
      shortNames.add(shortName);
    }
    return shortNames;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getFacultiesList() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> faculties = [];
    QuerySnapshot<Map<String, dynamic>> temp =
        await dbRefUniversal.collection('faculties').get();
    for (var item in temp.docs) {
      faculties.add(item);
    }
    return faculties;
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getFacultyByShortName(
      String name) async {
    QuerySnapshot<Map<String, dynamic>> temp =
        await dbRefUniversal.collection('faculties').get();
    for (var item in temp.docs) {
      if (item['shortName'] == name) {
        return item;
      }
    }
    throw 'Факультет не найден';
  }
}
