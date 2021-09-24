import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/pages/admission_info/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdmissionInfoAdd extends StatefulWidget {
  const AdmissionInfoAdd({Key? key}) : super(key: key);

  @override
  _AdmissionInfoAddState createState() => _AdmissionInfoAddState();
}

class _AdmissionInfoAddState extends State<AdmissionInfoAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  InfoCard _info = InfoCard();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _info.addCard(
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите оглавление';
                      }
                      return null;
                    },
                    decoration:
                    const InputDecoration(labelText: 'Оглавление'),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  TextFormField(
                    controller: _subtitleController,
                    decoration: const InputDecoration(labelText: 'Описание'),
                    minLines: 1,
                    maxLines: 18,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _onSubmit();
                  },
                  child: Text('Добавить'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(mainColor),
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: mainColor),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Отмена'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(mainColor),
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: mainColor),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
