import 'package:cloud_firestore/cloud_firestore.dart';

class Faculty {
  String? name;
  String? shortName;
  String? about;
  String? imagePath;
  //TODO: add 'phone number' and 'show at map'

  Faculty({this.name, this.shortName, this.about, this.imagePath});

  final dbRef = FirebaseFirestore.instance;

  void addFaculty(String name, String shortName, String about, String imagePath) async {
    await dbRef.collection('faculties').add({
      'name': name,
      'shortName': shortName,
      'about': about,
      'imagePath': imagePath,
    });
  }

  void editFaculty(String name, String shortName, String about,
      String imagePath, String id) async {
    await dbRef.collection('faculties').doc(id).update({
      'name': name,
      'shortName': shortName,
      'about': about,
      'imagePath': imagePath,
    });
  }

  void removeFaculty(String id) async {
    await dbRef.collection('faculties').doc(id).delete();
  }
}
