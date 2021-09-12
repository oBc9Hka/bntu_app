import 'package:bntu_app/main.dart';
import 'package:bntu_app/models/faculty_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FacultyEdit extends StatefulWidget {
  const FacultyEdit({Key? key, required this.faculty}) : super(key: key);
  final QueryDocumentSnapshot<Object?> faculty;

  @override
  _FacultyEditState createState() => _FacultyEditState();
}

class _FacultyEditState extends State<FacultyEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  Faculty _faculty = Faculty();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortNameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _hotLineNumberController = TextEditingController();
  TextEditingController _hotLineMailController = TextEditingController();
  TextEditingController _forInquiriesNumberController = TextEditingController();
  TextEditingController _forHostelNumberController = TextEditingController();
  TextEditingController _imagePathController = TextEditingController();

  void _editFaculty() {
    if (_formKey.currentState!.validate()) {
      _faculty.editFaculty(
        _nameController.text,
        _shortNameController.text,
        _aboutController.text,
        _hotLineNumberController.text,
        _hotLineMailController.text,
        _forInquiriesNumberController.text,
        _forHostelNumberController.text,
        _imagePathController.text,
        widget.faculty.id,
      );
      Navigator.of(context).pop();
    }
  }

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
              'Хотите удалить факультет?',
              style: TextStyle(fontSize: 18),//TODO: дообавить проверку намерения путём написания аббревиатуры
            )),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _faculty.removeFaculty(item.id);
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(msg: 'Факультет ${item['shortName']} успешно удалён');
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

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.faculty['name']);
    _shortNameController =
        TextEditingController(text: widget.faculty['shortName']);
    _aboutController = TextEditingController(text: widget.faculty['about']);
    _imagePathController =
        TextEditingController(text: widget.faculty['imagePath']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование ${widget.faculty['shortName']}')
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
                    controller: _nameController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите название';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Полное название'),
                    maxLines: 2,
                    cursorColor: Colors.black,
                  ),
                  TextFormField(
                    controller: _shortNameController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите аббревиатуру';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Аббревиатура'),
                    cursorColor: Colors.black,
                  ),
                  TextFormField(
                    controller: _aboutController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите описание';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Описание'),
                    maxLines: 8,
                    cursorColor: Colors.black,
                  ),
                  // TODO: image loading
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _editFaculty();
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
                    showAlertDialog(context, widget.faculty);
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
