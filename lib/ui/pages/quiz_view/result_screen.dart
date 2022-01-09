import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/greeting_screen.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/faculty_model.dart';
import 'main_menu.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.tagsList,
    required this.isFacultiesQuiz,
  }) : super(key: key);
  final tagsList;
  final bool isFacultiesQuiz;

  @override
  Widget build(BuildContext context) {
    var _fit = '...';
    var _mayFit = '...';
    var list = [];
    var _sortedList = <MapEntry<String, int>>[];
    var _tagsFrequency = <String, int>{};
    var maxFrequency = 0;
    var _mayFitVisibility = true;

    void _getTagsFrequencyList() {
      list = [];
      for (var item in tagsList) {
        if (list.contains(item)) {
          var count = _tagsFrequency[item];
          _tagsFrequency[item] = count! + 1;
        } else {
          _tagsFrequency[item] = 1;
          list.add(item);
        }
      }

      print(_tagsFrequency);
    }

    void _sortTagsFrequencyList() {
      _sortedList = [];
      _tagsFrequency.entries.forEach((element) {
        _sortedList.add(element);
      });
      print('unsorted: $_sortedList');
      _sortedList.sort((a, b) => b.value.compareTo(a.value));
      print('sorted: $_sortedList');
    }

    void _getMaxFrequency() {
      maxFrequency = 0;
      _tagsFrequency.forEach((key, value) {
        if (value > maxFrequency) maxFrequency = value;
      });
      print('maxFrequency: $maxFrequency');
    }

    void _setTitles() {
      var maxFrequencyCount = 0;
      _tagsFrequency.forEach((key, value) {
        if (value == maxFrequency) ++maxFrequencyCount;
      });
      print('maxFrequencyCount: $maxFrequencyCount');

      if (maxFrequencyCount == 1) {
        _fit = 'Тебе больше всего подходит:';
      } else {
        _fit = 'Тебе больше всего подходят:';
      }

      print('_tagsFrequency.length: ${_tagsFrequency.length}');
      if (_tagsFrequency.length - maxFrequencyCount == 1) {
        _mayFit = 'Также тебе может подойти:';
      } else {
        _mayFit = 'Также тебе могут подойти:';
      }
      if (_tagsFrequency.length - maxFrequencyCount == 0) {
        _mayFitVisibility = false;
      }
    }

    Faculty _getFacultyByShortName(String name, List<Faculty> list) {
      for (var faculty in list) {
        if (faculty.shortName == name) {
          return faculty;
        }
      }
      throw 'Факультет не найден';
    }

    _getTagsFrequencyList();
    _sortTagsFrequencyList();
    _fit = 'Тебе больше всего подходят:';
    if (isFacultiesQuiz) {
      _getMaxFrequency();
      _setTitles();
    }

    var fixedExtentScrollController = FixedExtentScrollController();
    const mainColor = Constants.mainColor;
    return Consumer<AppProvider>(builder: (context, state, child) {
      var sortedQueryList = <MapEntry<dynamic, int>>[];
      for (var sortedListItem in _sortedList) {
        for (var facultiesListItem in state.faculties) {
          if (facultiesListItem.shortName == sortedListItem.key) {
            sortedQueryList
                .add(MapEntry(facultiesListItem, sortedListItem.value));
          }
        }
      }
      var mayFitFacultyList = [];
      var mayFitFacultyIndex = 0;
      for (var item in sortedQueryList) {
        if (item.value < maxFrequency) {
          mayFitFacultyList.add(item);
        }
      }
      var _mockSorterList = [];
      if (!isFacultiesQuiz) {
        print('sortedQueryList: $sortedQueryList');
        print('firstFromSorted: ${_sortedList.first.key}');
        _mockSorterList = Constants.quizResultList
            .firstWhere((element) => element.letter == _sortedList.first.key)
            .specialties;
        print('itemsFromFirstFromSorted: $_mockSorterList');
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Результаты'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Результат теста:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    _fit,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isFacultiesQuiz
                      ? Column(
                          children: [
                            Column(
                              children: [
                                for (var item in sortedQueryList)
                                  if (item.value == maxFrequency)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FacultyPage(
                                              faculty: item.key,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        item.key.shortName,
                                        style: TextStyle(
                                            fontSize: 26, color: mainColor),
                                      ),
                                    ),
                              ],
                            ),
                            Visibility(
                              visible: _mayFitVisibility,
                              child: Column(
                                children: [
                                  Text(
                                    _mayFit,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 50,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FacultyPage(
                                              faculty: mayFitFacultyList[
                                                      mayFitFacultyIndex]
                                                  .key,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListWheelScrollView(
                                        controller: fixedExtentScrollController,
                                        physics: FixedExtentScrollPhysics(),
                                        itemExtent: 60.0,
                                        diameterRatio: 2,
                                        squeeze: 1,
                                        perspective: 0.01,
                                        onSelectedItemChanged: (index) {
                                          mayFitFacultyIndex = index;
                                        },
                                        children: [
                                          for (var item in mayFitFacultyList)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 100,
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FacultyPage(
                                                        faculty: item.key,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  item.key.shortName,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          child: ListView(
                            children: [
                              for (var item in _mockSorterList)
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FacultyPage(
                                          faculty: _getFacultyByShortName(
                                            item.values.first,
                                            state.faculties,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(item.keys.first),
                                  trailing: Text(item.values.first),
                                )
                            ],
                          ),
                        ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainMenu(
                            isFacultiesQuiz: isFacultiesQuiz,
                          ),
                        ),
                      );
                    },
                    style: Constants.customElevatedButtonStyle,
                    child: Text(
                      'Пройти тест заново',
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GreetingScreen(),
                          ));
                    },
                    style: Constants.customElevatedButtonStyle,
                    child: Text(
                      'Вернуться на главную',
                      style: TextStyle(color: mainColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({Key? key, required this.tagsList}) : super(key: key);
//   final tagsList;
//
//   @override
//   Widget build(BuildContext context) {
//     var _fit = '...';
//     var _mayFit = '...';
//     var list = [];
//     var _sortedList = <MapEntry<String, int>>[];
//     var _tagsFrequency = <String, int>{};
//     var maxFrequency = 0;
//     var _mayFitVisibility = true;
//
//     void _getTagsFrequencyList() {
//       list = [];
//       for (var item in tagsList) {
//         if (list.contains(item)) {
//           var count = _tagsFrequency[item];
//           _tagsFrequency[item] = count! + 1;
//         } else {
//           _tagsFrequency[item] = 1;
//           list.add(item);
//         }
//       }
//
//       print(_tagsFrequency);
//     }
//
//     void _sortTagsFrequencyList() {
//       _sortedList = [];
//       _tagsFrequency.entries.forEach((element) {
//         _sortedList.add(element);
//       });
//       print('unsorted: $_sortedList');
//       _sortedList.sort((a, b) => b.value.compareTo(a.value));
//       print('sorted: $_sortedList');
//     }
//
//     void _getMaxFrequency() {
//       maxFrequency = 0;
//       _tagsFrequency.forEach((key, value) {
//         if (value > maxFrequency) maxFrequency = value;
//       });
//       print('maxFrequency: $maxFrequency');
//     }
//
//     void _setTitles() {
//       var maxFrequencyCount = 0;
//       _tagsFrequency.forEach((key, value) {
//         if (value == maxFrequency) ++maxFrequencyCount;
//       });
//       print('maxFrequencyCount: $maxFrequencyCount');
//
//       if (maxFrequencyCount == 1) {
//         _fit = 'Тебе больше всего подходит:';
//       } else {
//         _fit = 'Тебе больше всего подходят:';
//       }
//
//       print('_tagsFrequency.length: ${_tagsFrequency.length}');
//       if (_tagsFrequency.length - maxFrequencyCount == 1) {
//         _mayFit = 'Также тебе может подойти:';
//       } else {
//         _mayFit = 'Также тебе могут подойти:';
//       }
//       if (_tagsFrequency.length - maxFrequencyCount == 0) {
//         _mayFitVisibility = false;
//       }
//     }
//
//     _getTagsFrequencyList();
//     _sortTagsFrequencyList();
//     // _getMaxFrequency();
//     // _setTitles();
//     _fit = 'Тебе больше всего подходят:';
//
//     var fixedExtentScrollController = FixedExtentScrollController();
//     const mainColor = Constants.mainColor;
//     return Consumer<AppProvider>(builder: (context, state, child) {
//       var sortedQueryList = <MapEntry<dynamic, int>>[];
//       for (var sortedListItem in _sortedList) {
//         for (var facultiesListItem in state.faculties) {
//           if (facultiesListItem.shortName == sortedListItem.key) {
//             sortedQueryList
//                 .add(MapEntry(facultiesListItem, sortedListItem.value));
//           }
//         }
//       }
//       var mayFitFacultyList = [];
//       var mayFitFacultyIndex = 0;
//       for (var item in sortedQueryList) {
//         if (item.value < maxFrequency) {
//           mayFitFacultyList.add(item);
//         }
//       }
//       print('sortedQueryList: $sortedQueryList');
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Результаты'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(
//             top: 10,
//             left: 10,
//             right: 10,
//             bottom: 40,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   'Результат теста:',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 40.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     _fit,
//                     style: TextStyle(
//                       color: mainColor,
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   for (var item in sortedQueryList)
//                     if (item.value == maxFrequency)
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => FacultyPage(
//                                 faculty: item.key,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           item.key.shortName,
//                           style: TextStyle(fontSize: 26, color: mainColor),
//                         ),
//                       ),
//                 ],
//               ),
//               Visibility(
//                 visible: _mayFitVisibility,
//                 child: Column(
//                   children: [
//                     Text(
//                       _mayFit,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       constraints: BoxConstraints(
//                           minWidth: 50,
//                           maxWidth: MediaQuery.of(context).size.width * 0.7,
//                           maxHeight: MediaQuery.of(context).size.height * 0.3),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => FacultyPage(
//                                 faculty:
//                                     mayFitFacultyList[mayFitFacultyIndex].key,
//                               ),
//                             ),
//                           );
//                         },
//                         child: ListWheelScrollView(
//                           controller: fixedExtentScrollController,
//                           physics: FixedExtentScrollPhysics(),
//                           itemExtent: 60.0,
//                           diameterRatio: 2,
//                           squeeze: 1,
//                           perspective: 0.01,
//                           onSelectedItemChanged: (index) {
//                             mayFitFacultyIndex = index;
//                           },
//                           children: [
//                             for (var item in mayFitFacultyList)
//                               Container(
//                                 constraints: BoxConstraints(
//                                   minWidth: 100,
//                                   maxWidth:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => FacultyPage(
//                                           faculty: item.key,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     item.key.shortName,
//                                     style: TextStyle(color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MainMenu(),
//                           ));
//                     },
//                     style: Constants.customElevatedButtonStyle,
//                     child: Text(
//                       'Пройти тест заново',
//                       style: TextStyle(color: mainColor),
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 10)),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => GreetingScreen(),
//                           ));
//                     },
//                     style: Constants.customElevatedButtonStyle,
//                     child: Text(
//                       'Вернуться на главную',
//                       style: TextStyle(color: mainColor),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
