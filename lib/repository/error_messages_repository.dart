import 'dart:async';

import 'package:bntu_app/models/error_message_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorMessagesFirestoreRepository extends ErrorMessagesRepository{
  final dbErrorRef = FirebaseFirestore.instance.collection('errorMessages');

  @override
  Future<void> changeViewedState(String id) async {
    await dbErrorRef.doc(id).update({'viewed': true});
  }

  @override
  Future<String> getUnseenMessages() async {
    int _count = 0;
    QuerySnapshot<Map<String, dynamic>> item =
        await dbErrorRef.where('viewed', isEqualTo: false).get();
    _count = item.docs.length;
    return _count.toString();
  }

  @override
  Future<void> removeErrorMessage(String id) async {
    await dbErrorRef.doc(id).delete();
  }

  @override
  Future<void> submitErrorMessage(String msg) async {
    await dbErrorRef
        .add({'message': msg, 'added': Timestamp.now(), 'viewed': false});
  }

  @override
  Future<List<ErrorMessage>> getErrorMessagesList() async {
    List<ErrorMessage> list = [];
    QuerySnapshot<Map<String, dynamic>> temp = await dbErrorRef.get();

    if(temp.docs.isEmpty){
      throw TimeoutException('Ошибка соединения');
    }

    for (var faculty in temp.docs){
      list.add(ErrorMessage.fromMap(faculty.data(), faculty.id));
    }

    list.sort((a, b) => b.added!.compareTo(a.added!));

    return list;
  }

}