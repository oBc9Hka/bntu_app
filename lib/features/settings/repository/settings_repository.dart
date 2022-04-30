import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/repository/settings_repository.dart';

class SettingsFirestoreRepository extends SettingsRepository {
  final dbRef = FirebaseFirestore.instance.collection('settings');

  @override
  Future<String> getCurrentAdmissionYear() async {
    return _getFieldData('currentAdmissionYear');
  }

  @override
  Future<String> getSecretKey() async {
    return _getFieldData('secretKey');
  }

  @override
  Future<String> getCheckedQuizId() {
    return _getFieldData('checkedQuizId');
  }

  @override
  Future<bool> getIsFacultyQuizChecked() async {
    var value = await dbRef.doc('commonSettings').get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == 'isFacultiesQuizChecked') _toReturn = item.value;
      }
      return _toReturn;
    });
    return value;
  }

  Future<String> _getFieldData(String fieldName) async {
    var value = await dbRef.doc('commonSettings').get().then((snapshot) {
      var _temp = snapshot.data()!.entries.toList();
      var _toReturn;
      for (var item in _temp) {
        if (item.key == fieldName) _toReturn = item.value;
      }
      return _toReturn;
    });
    return value;
  }

  @override
  Future<void> editSettings(String currentAdmissionYear, String key) async {
    await dbRef.doc('commonSettings').update({
      'currentAdmissionYear': currentAdmissionYear,
      'secretKey': key,
    });
  }

  @override
  Future<void> editQuizChecked(bool isFacultiesQuiz) async {
    await dbRef
        .doc('commonSettings')
        .update({'isFacultiesQuizChecked': isFacultiesQuiz});
  }

  @override
  Future<void> editCheckedQuiz(String checkedQuizId) async {
    await dbRef.doc('commonSettings').update({
      'checkedQuizId': checkedQuizId,
    });
  }
}
