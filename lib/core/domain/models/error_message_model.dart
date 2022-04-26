import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorMessage {
  String? message;
  bool? viewed;
  Timestamp? added;
  String? id;

  ErrorMessage({this.message, this.viewed, this.added, this.id});

  ErrorMessage.fromMap(Map<String, dynamic> data, String id)
      : this(
          message: data['message'],
          viewed: data['viewed'],
          added: data['added'],
          id: id,
        );
}
