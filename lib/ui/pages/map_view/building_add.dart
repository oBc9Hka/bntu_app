import 'package:flutter/material.dart';

import 'building_form.dart';

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
