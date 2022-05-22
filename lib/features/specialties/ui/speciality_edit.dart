import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/edit_buttons_section.dart';
import '../../../core/widgets/remove_item.dart';
import '../provider/specialties_provider.dart';
import 'widgets/speciality_form.dart';

class SpecialityEdit extends StatefulWidget {
  const SpecialityEdit({Key? key}) : super(key: key);

  @override
  _SpecialityAddStEdit createState() => _SpecialityAddStEdit();
}

class _SpecialityAddStEdit extends State<SpecialityEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _editSpeciality(String id, SpecialtiesProvider state) {
    if (_formKey.currentState!.validate()) {
      state.editSpeciality(state.specialityInEdit);

      _formKey.currentState!.reset();
      Navigator.of(context).pop();
      state.getSpecialties();
      Fluttertoast.showToast(msg: 'Специальность успешно изменена');
    }
  }

  void _removeSpeciality(String id, SpecialtiesProvider state) {
    state.removeSpeciality(id);
    state.getSpecialties();
    Navigator.pop(context);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Специальность успешно удалена');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изменение специальности'),
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
              EditButtonsSection(
                onEditPressed: () {
                  _editSpeciality(state.specialityInEdit.id.toString(), state);
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'специальность',
                        onRemovePressed: () {
                          _removeSpeciality(
                              state.specialityInEdit.id.toString(), state);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
