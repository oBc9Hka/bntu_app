import 'package:bntu_app/pages/map_view/building_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class BuildingEdit extends StatelessWidget {
  const BuildingEdit({Key? key, required this.building}) : super(key: key);
  final QueryDocumentSnapshot<Object?> building;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изменение точки'),
      ),
      body: BuildingForm(building: building, isEdit: true),
    );
  }
}
