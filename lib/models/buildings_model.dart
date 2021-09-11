import 'package:yandex_mapkit/yandex_mapkit.dart';

class Building {
  String name;
  String optional;
  bool isActive;
  Point point;

  Building(
      {required this.name, required this.optional, required this.isActive, required this.point});
  //TODO: add support with firebase
}