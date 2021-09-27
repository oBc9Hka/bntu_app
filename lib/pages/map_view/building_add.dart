import 'package:bntu_app/pages/map_view/building_form.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class BuildingAdd extends StatelessWidget {
  const BuildingAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление точки'),
      ),
      body: BuildingForm(isEdit: false),
    );
  }
}
