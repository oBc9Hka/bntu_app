import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/image_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'faculty_form.dart';

class FacultyEdit extends StatefulWidget {
  const FacultyEdit({Key? key, required this.faculty}) : super(key: key);
  final Faculty faculty;

  @override
  _FacultyEditState createState() => _FacultyEditState();
}

class _FacultyEditState extends State<FacultyEdit> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortNameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  TextEditingController _hotLineNumberController = TextEditingController();
  TextEditingController _hotLineMailController = TextEditingController();
  TextEditingController _forInquiriesNumberController = TextEditingController();
  TextEditingController _forHostelNumberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    setState(() {});
  }

  UploadTask? uploadFile(Uint8List data) {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref('faculties/${_shortNameController.text.trim()}/photo.jpg');
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

  void _editFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String id,
    AppProvider state,
  ) async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        await saveImage().whenComplete(() {
          state.editFaculty(
            name,
            shortName,
            about,
            hotLineNumber,
            hotLineMail,
            forInquiriesNumber,
            forHostelNumber,
            _imagePath,
            id,
          );
          Navigator.of(context).pop();
        });
      } else {
        state.editFaculty(
          name,
          shortName,
          about,
          hotLineNumber,
          hotLineMail,
          forInquiriesNumber,
          forHostelNumber,
          _imagePath,
          id,
        );
      }
      Navigator.of(context).pop();
      state.initFaculties();
      Fluttertoast.showToast(msg: 'Факультет успешно изменён');
    }
  }

  void _removeFaculty(
      BuildContext context, Faculty item, GestureTapCallback onRemovePressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 40,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Хотите удалить факультет?',
                    style: TextStyle(fontSize: 18),
                    //TODO: дообавить проверку намерения путём написания аббревиатуры
                  ),
                  Text(item.shortName.toString()),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: onRemovePressed,
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
    _nameController = TextEditingController(text: widget.faculty.name);
    _shortNameController =
        TextEditingController(text: widget.faculty.shortName);
    _aboutController = TextEditingController(text: widget.faculty.about);
    _hotLineNumberController =
        TextEditingController(text: widget.faculty.hotLineNumber);
    _hotLineMailController =
        TextEditingController(text: widget.faculty.hotLineMail);
    _forInquiriesNumberController =
        TextEditingController(text: widget.faculty.forInquiriesNumber);
    _forHostelNumberController =
        TextEditingController(text: widget.faculty.forHostelNumber);
    _imagePath = widget.faculty.imagePath!;

    return Scaffold(
      appBar: AppBar(title: Text('Редактирование ${widget.faculty.shortName}')),
      body: Consumer<AppProvider>(
        builder: (context, state, child) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    FacultyForm(
                        faculty: widget.faculty,
                        formKey: _formKey,
                        nameController: _nameController,
                        shortNameController: _shortNameController,
                        aboutController: _aboutController,
                        hotLineNumberController: _hotLineNumberController,
                        hotLineMailController: _hotLineMailController,
                        forInquiriesNumberController:
                            _forInquiriesNumberController,
                        forHostelNumberController: _forHostelNumberController),
                    ImageLoading(
                      onLoadPressed: () {
                        getPhoto();
                      },
                      image: _image,
                      faculty: widget.faculty,
                    )
                  ],
                ),
              ),
              EditButtonsSection(
                onEditPressed: () {
                  _editFaculty(
                      _nameController.text.trim(),
                      _shortNameController.text.trim(),
                      _aboutController.text.trim(),
                      _hotLineNumberController.text.trim(),
                      _hotLineMailController.text.trim(),
                      _forInquiriesNumberController.text.trim(),
                      _forHostelNumberController.text.trim(),
                      widget.faculty.id.toString(),
                      state);
                },
                onRemovePressed: () {
                  _removeFaculty(context, widget.faculty, () {
                    state.removeFaculty(widget.faculty.id.toString(),
                        _shortNameController.text.trim());

                    Navigator.pop(context);
                    Navigator.pop(context);
                    state.initFaculties();
                    Fluttertoast.showToast(
                        msg:
                            'Факультет ${widget.faculty.shortName} успешно удалён');
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
