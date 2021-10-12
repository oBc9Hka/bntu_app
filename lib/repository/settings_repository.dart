import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<String> _getFieldData(String fieldName) async {
    String value = await dbRef.doc('commonSettings').get().then((snapshot) {
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
  Future<void> editSettings(String currentAdmissionYear, String key) async{
    await dbRef.doc('commonSettings').update({
      'currentAdmissionYear': currentAdmissionYear,
      'secretKey': key,
    });
  }

}