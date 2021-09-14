import 'package:bntu_app/pages/faculties_views/faculty_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacultyEdit extends StatefulWidget {
  const FacultyEdit({Key? key, required this.faculty}) : super(key: key);
  final QueryDocumentSnapshot<Object?> faculty;

  @override
  _FacultyEditState createState() => _FacultyEditState();
}

class _FacultyEditState extends State<FacultyEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование ${widget.faculty['shortName']}')
      ),
      body: FacultyForm(isEdit: true, faculty: widget.faculty,),
    );
  }
}
