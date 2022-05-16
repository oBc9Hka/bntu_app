import 'package:yandex_mapkit/yandex_mapkit.dart';

class Building {
  String? name;
  String? description;
  String? optional;
  Point? point;
  String? imagePath;
  String? docId;
  int? orderId;

  Building({
    this.name,
    this.description,
    this.optional,
    this.point,
    this.imagePath,
    this.docId,
    this.orderId,
  });

  Building.fromMap(Map<String, dynamic> data, String id)
      : this(
          name: data['name'],
          description: data['description'],
          optional: data['optional'],
          point: Point(
              latitude: data['point'].latitude,
              longitude: data['point'].longitude),
          imagePath: data['imagePath'],
          docId: id,
          orderId: data['orderId'],
        );
}
