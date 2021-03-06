import 'dart:async';

import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../domain/repository/faculties_repository.dart';

class FacultiesFirestoreRepository extends FacultiesRepository {
  final dbRef = FirebaseFirestore.instance.collection('faculties');

  @override
  Future<void> addFaculty(
      String name,
      String shortName,
      String about,
      String hotLineNumber,
      String hotLineMail,
      String forInquiriesNumber,
      String forHostelNumber,
      String imagePath) async {
    await dbRef.add({
      'name': name,
      'shortName': shortName,
      'about': about,
      'hotLineNumber': hotLineNumber,
      'hotLineMail': hotLineMail,
      'forInquiriesNumber': forInquiriesNumber,
      'forHostelNumber': forHostelNumber,
      'imagePath': imagePath,
    });
  }

  @override
  Future<void> editFaculty(
      String name,
      String shortName,
      String about,
      String hotLineNumber,
      String hotLineMail,
      String forInquiriesNumber,
      String forHostelNumber,
      String imagePath,
      String id) async {
    await dbRef.doc(id).update({
      'name': name,
      'shortName': shortName,
      'about': about,
      'hotLineNumber': hotLineNumber,
      'hotLineMail': hotLineMail,
      'forInquiriesNumber': forInquiriesNumber,
      'forHostelNumber': forHostelNumber,
      'imagePath': imagePath,
    });
  }

  @override
  Future<List<Faculty>> getFacultiesList() async {
    var list = <Faculty>[];
    final temp = await dbRef.get();

    if (temp.docs.isEmpty) {
      throw TimeoutException('Ошибка соединения');
    }

    for (var faculty in temp.docs) {
      list.add(Faculty.fromMap(faculty.data(), faculty.id));
    }

    list.sort((a, b) => a.shortName!.compareTo(b.shortName!));

    return list;
  }

  @override
  Future<void> removeFaculty(String id, String name) async {
    try {
      await FirebaseStorage.instance.ref('faculties/$name/photo.jpg').delete();
    } catch (_) {}
    await dbRef.doc(id).delete();
  }

  @override
  Future<List<String>> getFacultiesShortNames() async {
    var shortNames = <String>[];
    var temp = await dbRef.get();
    for (var item in temp.docs) {
      String shortName = item['shortName'];
      shortNames.add(shortName);
    }
    return shortNames;
  }

  @override
  Future<Faculty> getFacultyByShortName(String name) async {
    var temp = await dbRef.get();
    for (var item in temp.docs) {
      if (item['shortName'] == name) {
        return Faculty.fromMap(item.data(), item.id);
      }
    }
    throw 'Факультет не найден';
  }
}
