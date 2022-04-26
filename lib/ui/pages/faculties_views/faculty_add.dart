import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/ui/widgets/add_buttons_section.dart';
import 'package:bntu_app/ui/widgets/image_loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'faculty_form.dart';

class FacultyAdd extends StatefulWidget {
  const FacultyAdd({Key? key}) : super(key: key);

  @override
  _FacultyAddState createState() => _FacultyAddState();
}

class _FacultyAddState extends State<FacultyAdd> {
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
  UploadTask? _task;
  final ImagePicker _picker = ImagePicker();

  void _addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    AppProvider state,
  ) async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        await saveImage().whenComplete(() {
          state.addFaculty(name, shortName, about, hotLineNumber, hotLineMail,
              forInquiriesNumber, forHostelNumber, _imagePath);
          Navigator.of(context).pop();
        });
      } else {
        state.addFaculty(name, shortName, about, hotLineNumber, hotLineMail,
            forInquiriesNumber, forHostelNumber, _imagePath);
      }
      Navigator.of(context).pop();
      state.initFaculties();
      Fluttertoast.showToast(msg: 'Факультет успешно добавлен');
    }
  }

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

    _task = uploadFile(data!);
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
                  if (_task != null) buildUploadStatus(_task!)
                ],
              ),
            ),
            backgroundColor: themeProvider.brightness == CustomBrightness.light
                ? Colors.white70
                : Colors.black54,
          );
        });

    if (_task == null) return;

    final TaskSnapshot storageTaskSnapshot = await _task!.whenComplete(() {
      _task = null;
    });
    final String path = await storageTaskSnapshot.ref.getDownloadURL();

    _imagePath = path;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить факультет'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, state, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    FacultyForm(
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
                    ),
                  ],
                ),
              ),
              AddButtonsSection(onAddPressed: () {
                _addFaculty(
                  _nameController.text.trim(),
                  _shortNameController.text.trim(),
                  _aboutController.text.trim(),
                  _hotLineNumberController.text.trim(),
                  _hotLineMailController.text.trim(),
                  _forInquiriesNumberController.text.trim(),
                  _forHostelNumberController.text.trim(),
                  state,
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
