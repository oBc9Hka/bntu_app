import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:bntu_app/util/validate_email.dart';
import 'package:flutter/material.dart';

class FacultyForm extends StatelessWidget {
  const FacultyForm({
    Key? key,
    this.faculty,
    required this.formKey,
    required this.nameController,
    required this.shortNameController,
    required this.aboutController,
    required this.hotLineNumberController,
    required this.hotLineMailController,
    required this.forInquiriesNumberController,
    required this.forHostelNumberController,
  }) : super(key: key);
  final Faculty? faculty;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController shortNameController;
  final TextEditingController aboutController;

  final TextEditingController hotLineNumberController;
  final TextEditingController hotLineMailController;
  final TextEditingController forInquiriesNumberController;
  final TextEditingController forHostelNumberController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите название';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Полное название'),
                      minLines: 1,
                      maxLines: 2,
                    ),
                    TextFormField(
                      controller: shortNameController,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите аббревиатуру';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Аббревиатура'),
                    ),
                    TextFormField(
                      controller: aboutController,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите описание';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Описание'),
                      minLines: 1,
                      maxLines: 8,
                    ),
                    TextFormField(
                      controller: hotLineNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Номер горячей линии'),
                    ),
                    TextFormField(
                      controller: hotLineMailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите почту';
                        }
                        if (!validateEmail(value!.trim())) {
                          return 'Почта заполнена некорректно';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Почта горячей линии'),
                    ),
                    TextFormField(
                      controller: forInquiriesNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Номер для вопросов по справкам'),
                    ),
                    TextFormField(
                      controller: forHostelNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Номер по вопросам общежития'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
