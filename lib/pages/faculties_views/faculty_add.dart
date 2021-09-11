import 'package:bntu_app/models/faculty_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacultyAdd extends StatefulWidget {
  const FacultyAdd({Key? key}) : super(key: key);

  @override
  _FacultyAddState createState() => _FacultyAddState();
}

class _FacultyAddState extends State<FacultyAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  Faculty _faculty = Faculty();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortNameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _imagePathController = TextEditingController();

  void _addFaculty() {
    if (_formKey.currentState!.validate()) {
      _faculty.addFaculty(
        _nameController.text,
        _shortNameController.text,
        _aboutController.text,
        _imagePathController.text,
      );
      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить факультет'),
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addFaculty();
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
