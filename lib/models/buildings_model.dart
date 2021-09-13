import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Building {
  String? name;
  String? optional;

  // bool isActive;
  Point? point;
  String? imagePath;


  Building({this.name, this.optional, this.point, this.imagePath});

  final dbRef = FirebaseFirestore.instance;

  void addBuilding(
    String name,
    String optional,
    Point point,
    String imagePath,
  ) async {
    await dbRef.collection('buildings').add({
      'name': name,
      'optional': optional,
      'point': GeoPoint(point.latitude, point.longitude),
      'imagePath': imagePath,
    });
  }

  void editBuilding(
      String name,
      String optional,
      Point point,
      String imagePath,
      String id,
      ) async {
    await dbRef.collection('buildings').doc(id).update({
      'name': name,
      'optional': optional,
      'point': GeoPoint(point.latitude, point.longitude),
      'imagePath': imagePath,
    });
  }

  void removeBuilding(String id) async{
    await dbRef.collection('buildings').doc(id).delete();
  }

  void updateImage(){}
}
