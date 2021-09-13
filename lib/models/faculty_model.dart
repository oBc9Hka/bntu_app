import 'package:cloud_firestore/cloud_firestore.dart';

class Faculty {
  String? name;
  String? shortName;
  String? about;
  String? hotLineNumber;
  String? hotLineMail;
  String? forInquiriesNumber;
  String? forHostelNumber;
  String? imagePath;

  Faculty(
      {this.name,
      this.shortName,
      this.about,
      this.hotLineNumber,
      this.hotLineMail,
      this.forInquiriesNumber,
      this.forHostelNumber,
      this.imagePath});

  final dbRef = FirebaseFirestore.instance;

  void addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
  ) async {
    await dbRef.collection('faculties').add({
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

  void editFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
    String id,
  ) async {
    await dbRef.collection('faculties').doc(id).update({
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

  void removeFaculty(String id) async {
    await dbRef.collection('faculties').doc(id).delete();
  }
}
