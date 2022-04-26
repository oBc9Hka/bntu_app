import 'package:bntu_app/features/admission_info/domain/models/info_cards_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/edit_buttons_section.dart';
import '../../../core/widgets/remove_item.dart';
import '../provider/admission_info_provider.dart';
import 'widgets/info_form.dart';

class AdmissionInfoEdit extends StatefulWidget {
  const AdmissionInfoEdit({Key? key, required this.infoCard}) : super(key: key);
  final InfoCard infoCard;

  @override
  _AdmissionInfoEditState createState() => _AdmissionInfoEditState();
}

class _AdmissionInfoEditState extends State<AdmissionInfoEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  void _onSubmit(String id, AdmissionInfoProvider state) {
    if (_formKey.currentState!.validate()) {
      state.editInfoCard(
        _titleController.text,
        _subtitleController.text,
        id,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.infoCard.title);
    _subtitleController = TextEditingController(text: widget.infoCard.subtitle);

    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать карточку'),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoForm(
                  formKey: _formKey,
                  titleController: _titleController,
                  subtitleController: _subtitleController,
                ),
                Consumer<AdmissionInfoProvider>(
                  builder: (context, state, child) {
                    return EditButtonsSection(
                      onEditPressed: () {
                        _onSubmit(widget.infoCard.docId.toString(), state);
                      },
                      onRemovePressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RemoveItem(
                              itemName: 'карточку',
                              onRemovePressed: () {
                                state.removeInfoCard(
                                    widget.infoCard.docId.toString());
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: 'Карточка успешно удалена');
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
