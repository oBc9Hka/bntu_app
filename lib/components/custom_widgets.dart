// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void showAlertDialog(
//     BuildContext context, QueryDocumentSnapshot<Object?> item) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Container(
//           height: 22,
//           child: const Center(
//               child: Text(
//                 'Хотите удалить факультет?',
//                 style: TextStyle(fontSize: 18),
//               )),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               _faculty.removeFaculty(item.id);
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.red),
//             ),
//             child: const Text('Удалить'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               setState(() {});
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.black38),
//             ),
//             child: const Text('Отмена'),
//           )
//         ],
//       );
//     },
//   );
// }