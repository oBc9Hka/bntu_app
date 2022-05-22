import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/add_buttons_section.dart';
import '../provider/specialties_provider.dart';
import 'widgets/speciality_form.dart';

class SpecialityAdd extends StatefulWidget {
  const SpecialityAdd({
    Key? key,
  }) : super(key: key);

  @override
  _SpecialityAddState createState() => _SpecialityAddState();
}

class _SpecialityAddState extends State<SpecialityAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Speciality speciality = Speciality();

  void _addSpeciality(SpecialtiesProvider state) {
    if (_formKey.currentState!.validate()) {
      state.addSpeciality();

      _formKey.currentState!.reset();
      Navigator.of(context).pop();
      state.getSpecialties();
      Fluttertoast.showToast(msg: 'Специальность успешно добавлена');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление специальности'),
      ),
      body: Consumer<SpecialtiesProvider>(
        builder: (context, state, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SpecialityForm(
                      formKey: _formKey,
                    )
                  ],
                ),
              ),
              AddButtonsSection(onAddPressed: () {
                _addSpeciality(state);
              }),
            ],
          );
        },
      ),
    );
  }
}
