import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorMessage {
  String? message;

  ErrorMessage({this.message});

  final dbErrorRef = FirebaseFirestore.instance.collection('errorMessages');

  void submitErrorMessage(String msg) async {
    await dbErrorRef.add({'message': msg, 'added': Timestamp.now(), 'viewed' : false});
  }

  void changeViewedState(String id){
    dbErrorRef.doc(id).update({'viewed' : true});
  }

  void removeErrorMessage(String id) {
    dbErrorRef.doc(id).delete();
  }

  Future<String> getUnseenMessages()async{
    int _count = 0;
    QuerySnapshot<Map<String, dynamic>> item = await dbErrorRef.where('viewed', isEqualTo: false).get();
    _count = item.docs.length;
    return _count.toString();
  }
}
