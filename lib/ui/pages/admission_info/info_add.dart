import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/admission_info/info_form.dart';
import 'package:bntu_app/ui/widgets/add_buttons_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdmissionInfoAdd extends StatefulWidget {
  const AdmissionInfoAdd({Key? key}) : super(key: key);

  @override
  _AdmissionInfoAddState createState() => _AdmissionInfoAddState();
}

class _AdmissionInfoAddState extends State<AdmissionInfoAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  void _onSubmit(AppProvider state) {
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
      body: Consumer<AppProvider>(
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
