import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/util/validate_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FacultyForm extends StatefulWidget {
  const FacultyForm({Key? key, this.faculty, required this.isEdit})
      : super(key: key);
  final QueryDocumentSnapshot<Object?>? faculty;
  final bool isEdit;

  @override
  _FacultyFormState createState() => _FacultyFormState();
}

class _FacultyFormState extends State<FacultyForm> {
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

  XFile? _image;
  String _imagePath = '';
  UploadTask? task;
  final ImagePicker _picker = ImagePicker();

  void getPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future<void> saveImage() async {
    Uint8List? data;
    await File(_image!.path)
        .readAsBytes()
        .then((value) => {data = Uint8List.fromList(value)});

    task = uploadFile(data!);
    setState(() {});
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var themeProvider = Provider.of<ThemeProvider>(context);
          return AlertDialog(
            title: Text('Пожалуйста, подождите'),
            content: SizedBox(
              height: 50,
              child: Column(
                children: [
                  Text('Идёт сохранение изменений'),
                  if (task != null) buildUploadStatus(task!)
                ],
              ),
            ),
            backgroundColor: themeProvider.brightness == CustomBrightness.light
                ? Colors.white70
                : Colors.black54,
          );
        });

    if (task == null) return;

    final TaskSnapshot storageTaskSnapshot = await task!.whenComplete(() {
      task = null;
    });
    final String path = await storageTaskSnapshot.ref.getDownloadURL();

    _imagePath = path;
  }

  UploadTask? uploadFile(Uint8List data) {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref('faculties/${_shortNameController.text}/photo.jpg');
      // return storageReference.putFile(File(_image.path));

      return storageReference.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(1);

            return Container(
              child: Center(
                child: Text('$percentage%'),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  void _addFaculty() async {
    if (_formKey.currentState!.validate()) {
      if(_image != null){
        await saveImage().whenComplete(() {
          _faculty.addFaculty(
            _nameController.text.trim(),
            _shortNameController.text.trim(),
            _aboutController.text.trim(),
            _hotLineNumberController.text.trim(),
            _hotLineMailController.text.trim(),
            _forInquiriesNumberController.text.trim(),
            _forHostelNumberController.text.trim(),
            _imagePath,
          );
          Navigator.of(context).pop();
        });
      }else {
        _faculty.addFaculty(
          _nameController.text.trim(),
          _shortNameController.text.trim(),
          _aboutController.text.trim(),
          _hotLineNumberController.text.trim(),
          _hotLineMailController.text.trim(),
          _forInquiriesNumberController.text.trim(),
          _forHostelNumberController.text.trim(),
          _imagePath,
        );
      }
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Факультет успешно добавлен');
    }
  }

  void _editFaculty(String id) async {
    if (_formKey.currentState!.validate()) {
      if(_image != null){
        await saveImage().whenComplete(() {
          _faculty.editFaculty(
            _nameController.text.trim(),
            _shortNameController.text.trim(),
            _aboutController.text.trim(),
            _hotLineNumberController.text.trim(),
            _hotLineMailController.text.trim(),
            _forInquiriesNumberController.text.trim(),
            _forHostelNumberController.text.trim(),
            _imagePath,
            id,
          );
          Navigator.of(context).pop();
        });
      }else {
        _faculty.editFaculty(
          _nameController.text.trim(),
          _shortNameController.text.trim(),
          _aboutController.text.trim(),
          _hotLineNumberController.text.trim(),
          _hotLineMailController.text.trim(),
          _forInquiriesNumberController.text.trim(),
          _forHostelNumberController.text.trim(),
          _imagePath,
          id,
        );
      }
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Факультет успешно изменён');
    }
  }

  void _removeFaculty(
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
                style: TextStyle(fontSize: 18),
                //TODO: дообавить проверку намерения путём написания аббревиатуры
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _faculty.removeFaculty(item.id);
                FirebaseStorage.instance
                    .ref('faculties/${_nameController.text}/photo.jpg')
                    .delete();
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: 'Факультет ${item['shortName']} успешно удалён');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _nameController = TextEditingController(text: widget.faculty!['name']);
      _shortNameController =
          TextEditingController(text: widget.faculty!['shortName']);
      _aboutController = TextEditingController(text: widget.faculty!['about']);
      _hotLineNumberController = TextEditingController(text: widget.faculty!['hotLineNumber']);
      _hotLineMailController = TextEditingController(text: widget.faculty!['hotLineMail']);
      _forInquiriesNumberController = TextEditingController(text: widget.faculty!['forInquiriesNumber']);
      _forHostelNumberController = TextEditingController(text: widget.faculty!['forHostelNumber']);
      _imagePath = widget.faculty!['imagePath'];
    }
    return ListView(
      children: [
        Padding(
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
                      minLines: 1,
                      maxLines: 2,
                    ),
                    TextFormField(
                      controller: _shortNameController,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите аббревиатуру';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Аббревиатура'),
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
                      minLines: 1,
                      maxLines: 8,
                    ),


                    TextFormField(
                      controller: _hotLineNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Номер горячей линии'),
                    ),
                    TextFormField(
                      controller: _hotLineMailController,
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
                      decoration: const InputDecoration(labelText: 'Почта горячей линии'),
                    ),
                    TextFormField(
                      controller: _forInquiriesNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Номер для вопросов по справкам'),
                    ),
                    TextFormField(
                      controller: _forHostelNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '') {
                          return 'Введите номер';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Номер по вопросам общежития'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getPhoto();
                  },
                  child: Text('Загрузить изображение')),
              if (_image != null)
                Center(
                  child: Container(
                    width: 200,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.file(File(_image!.path)).image),
                    ),
                  ),
                )
              else if (widget.faculty != null && widget.faculty!['imagePath'] != '')
                Center(
                  child: Container(
                    width: 200,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                        Image.network(widget.faculty!['imagePath']).image,
                      ),
                    ),
                  ),
                )
              else
                Text('Изображение не загружено'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.isEdit
                        ? ElevatedButton(
                            onPressed: () {
                              _editFaculty(widget.faculty!.id);
                            },
                            child: Text('Изменить'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(mainColor),
                              minimumSize: MaterialStateProperty.all(Size(150, 50)),
                              elevation: MaterialStateProperty.all(10),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: mainColor),
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _addFaculty();
                            },
                            child: Text('Добавить'),
                            style: ButtonStyle(
                              // foregroundColor: MaterialStateProperty.all(mainColor),
                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                              elevation: MaterialStateProperty.all(10),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      child: Text('Назад'),
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
                    if (widget.isEdit)
                      ElevatedButton(
                        onPressed: () {
                          _removeFaculty(context, widget.faculty!);
                        },
                        child: Icon(Icons.delete),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.white),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
