import 'package:flutter/material.dart';

class InfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController subtitleController;

  const InfoForm(
      {Key? key,
      required this.formKey,
      required this.titleController,
      required this.subtitleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == '') {
                  return 'Введите оглавление';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Оглавление'),
              minLines: 1,
              maxLines: 2,
            ),
            TextFormField(
              controller: subtitleController,
              decoration: const InputDecoration(labelText: 'Описание'),
              minLines: 1,
              maxLines: 18,
            ),
          ],
        ),
      ),
    );
  }
}
