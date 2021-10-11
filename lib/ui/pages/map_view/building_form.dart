import 'package:bntu_app/models/buildings_model.dart';
import 'package:flutter/material.dart';

class BuildingForm extends StatelessWidget {
  const BuildingForm({
    Key? key,
    this.building,
    required this.nameController,
    required this.optionalController,
    required this.formKey,
  }) : super(key: key);
  final Building? building;
  final TextEditingController nameController;
  final TextEditingController optionalController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (value) {
                    if (value == '') return 'Введите название';
                    return null;
                  },
                ),
                TextFormField(
                  controller: optionalController,
                  decoration: const InputDecoration(
                      labelText: 'Дополнительная информация'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
