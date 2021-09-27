import 'package:bntu_app/pages/faculties_views/faculty_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacultyAdd extends StatefulWidget {
  const FacultyAdd({Key? key}) : super(key: key);

  @override
  _FacultyAddState createState() => _FacultyAddState();
}

class _FacultyAddState extends State<FacultyAdd> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить факультет'),
      ),
      body: FacultyForm(isEdit: false),
    );
  }
}
