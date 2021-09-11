import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/pages/admission_info/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdmissionInfoEdit extends StatefulWidget {
  const AdmissionInfoEdit({Key? key, required this.infoCard}) : super(key: key);
  final QueryDocumentSnapshot<Object?> infoCard;

  @override
  _AdmissionInfoEditState createState() => _AdmissionInfoEditState();
}

class _AdmissionInfoEditState extends State<AdmissionInfoEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  InfoCard _info = InfoCard();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  TextEditingController _orderController = TextEditingController();

  void showAlertDialog(
      BuildContext context, QueryDocumentSnapshot<Object?> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 22,
            child: const Center(
                child: Text(
                  'Хотите удалить карточку?',
                  style: TextStyle(fontSize: 18),//TODO: дообавить проверку намерения путём написания аббревиатуры
                )),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _info.removeCard(item.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('Удалить'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text('Отмена'),
            )
          ],
        );
      },
    );
  }

  void _onSubmit(String id) {
    if (_formKey.currentState!.validate()) {
      _info.editCard(
        _titleController.text,
        _subtitleController.text,
        int.parse(_orderController.text),
        id,
      );
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.infoCard['title']);
    _subtitleController = TextEditingController(text: widget.infoCard['subtitle']);
    _orderController = TextEditingController(text: widget.infoCard['orderId'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать карточку'),
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
                    maxLines: 2,
                    cursorColor: Colors.black,
                  ),
                  TextFormField(
                    controller: _subtitleController,
                    decoration: const InputDecoration(labelText: 'Описание'),
                    maxLines: 8,
                    cursorColor: Colors.black,
                  ),
                  TextFormField(
                    controller: _orderController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите ID';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'ID'),
                    maxLines: 1,
                    cursorColor: Colors.black,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _onSubmit(widget.infoCard.id);
                  },
                  child: Text('Изменить'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(mainColor),
                    minimumSize: MaterialStateProperty.all(Size(120, 50)),
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
                    minimumSize: MaterialStateProperty.all(Size(120, 50)),
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
                    showAlertDialog(context, widget.infoCard);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(mainColor),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(Size(50, 50)),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
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
