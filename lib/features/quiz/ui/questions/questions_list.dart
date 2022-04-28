// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bntu_app/features/quiz/ui/question_add.dart';
// import 'package:bntu_app/features/quiz/ui/question_edit.dart';
// import 'package:bntu_app/models/question_model.dart';
// import 'package:bntu_app/providers/app_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/constants/constants.dart';

// class QuestionsList extends StatefulWidget {
//   const QuestionsList({Key? key, required this.questions}) : super(key: key);
//   final String questions;

//   @override
//   _QuestionsListState createState() => _QuestionsListState();
// }

// class _QuestionsListState extends State<QuestionsList> {
//   List<QuestionModel> _questions = [];

//   @override
//   Widget build(BuildContext context) {
//     const mainColor = Constants.mainColor;
//     return Consumer<AppProvider>(builder: (context, state, child) {
//       if (widget.questions == 'f') {
//         _questions = state.facultiesQuestions;
//       } else if (widget.questions == 's') {
//         _questions = state.specialtiesQuestions;
//       }
//       print(_questions);
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Список вопросов'),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (BuildContext context) => QuestionAdd(
//                       questions: widget.questions,
//                     ),
//                   ),
//                 );
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//                 onPressed: () {
//                   state.initQuestions();
//                 },
//                 icon: Icon(Icons.refresh))
//           ],
//         ),
//         body: Center(
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: 600,
//             ),
//             child: ListView.builder(
//               itemCount: _questions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                   child: Card(
//                     child: ListTile(
//                       leading: Text('${index + 1}'),
//                       title: Text(
//                         _questions[index].question.toString(),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ..._questions[index].answers!.map((e) => AutoSizeText(
//                                 '${e.entries.first.key.length <= 10 ? e.entries.first.key.toString().trimRight() : e.entries.first.key.substring(0, 10).toString().trimRight() + '..'}: ${e.values.first}',
//                                 maxLines: 1,
//                                 style: TextStyle(fontSize: 12),
//                               )),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (BuildContext context) {
//                                 return QuestionEdit(
//                                   question: _questions[index],
//                                   questions: widget.questions,
//                                 );
//                               }));
//                             },
//                             icon: Icon(
//                               Icons.edit,
//                               color: mainColor,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               try {
//                                 if (widget.questions == 'f') {
//                                   state.moveUpFacultyQuestion(
//                                     _questions[index].id!,
//                                     _questions[index - 1].id!,
//                                   );
//                                 } else if (widget.questions == 's') {
//                                   state.moveUpSpecialityQuestion(
//                                     _questions[index].id!,
//                                     _questions[index - 1].id!,
//                                   );
//                                 }
//                                 // ignore: empty_catches
//                               } catch (e) {}
//                             },
//                             tooltip: 'Поднять в списке',
//                             icon: Icon(
//                               Icons.arrow_upward,
//                               color: mainColor,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               try {
//                                 if (widget.questions == 'f') {
//                                   state.moveDownFacultyQuestion(
//                                     _questions[index].id!,
//                                     _questions[index + 1].id!,
//                                   );
//                                 } else if (widget.questions == 's') {
//                                   state.moveDownSpecialityQuestion(
//                                     _questions[index].id!,
//                                     _questions[index + 1].id!,
//                                   );
//                                 }
//                                 // ignore: empty_catches
//                               } catch (e) {}
//                             },
//                             tooltip: 'Опустить в списке',
//                             icon: Icon(
//                               Icons.arrow_downward,
//                               color: mainColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
