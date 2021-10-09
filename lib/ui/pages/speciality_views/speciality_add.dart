// import 'package:bntu_app/ui/pages/speciality_views/speciality_form.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// class SpecialityAdd extends StatefulWidget {
//   const SpecialityAdd({Key? key, required this.faculty}) : super(key: key);
//   final QueryDocumentSnapshot<Object?> faculty;
//
//   @override
//   _SpecialityAddState createState() => _SpecialityAddState();
// }
//
// class _SpecialityAddState extends State<SpecialityAdd> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Добавление специальности'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SpecialityForm(faculty: widget.faculty, isEdit: false,),
//         ),
//       ),
//     );
//   }
// }
