import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/add_buttons_section.dart';
import '../provider/admission_info_provider.dart';
import 'widgets/info_form.dart';

class AdmissionInfoAdd extends StatefulWidget {
  const AdmissionInfoAdd({Key? key}) : super(key: key);

  @override
  _AdmissionInfoAddState createState() => _AdmissionInfoAddState();
}

class _AdmissionInfoAddState extends State<AdmissionInfoAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  void _onSubmit(AdmissionInfoProvider state) {
    if (_formKey.currentState!.validate()) {
      state.addInfoCard(
        _titleController.text,
        _subtitleController.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить карточку'),
      ),
      body: Consumer<AdmissionInfoProvider>(
        builder: (context, state, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoForm(
                  formKey: _formKey,
                  titleController: _titleController,
                  subtitleController: _subtitleController,
                ),
                AddButtonsSection(
                  onAddPressed: () {
                    _onSubmit(state);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
