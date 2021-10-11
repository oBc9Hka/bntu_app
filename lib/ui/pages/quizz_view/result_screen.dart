import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_menu.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.tagsList}) : super(key: key);

  final tagsList;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _fit = '...';
  String _mayFit = '...';
  List list = [];
  List<MapEntry<String, int>> _sortedList = [];
  Map<String, int> _tagsFrequency = {};
  int maxFrequency = 0;
  bool _mayFitVisibility = true;


  void _getTagsFrequencyList() {
    list = [];
    for (var item in widget.tagsList) {
      if (list.contains(item)) {
        int? count = _tagsFrequency[item];
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
    int maxFrequencyCount = 0;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getTagsFrequencyList();
    _sortTagsFrequencyList();
    _getMaxFrequency();
    _setTitles();



    const Color mainColor = Constants.mainColor;
    return Consumer<AppProvider>(
        builder: (context, state, child) {

          List<MapEntry<dynamic, int>> sortedQueryList = [];
          for (var sortedListItem in _sortedList) {
            for (var facultiesListItem in state.faculties) {
              if (facultiesListItem.shortName == sortedListItem.key)
                sortedQueryList
                    .add(MapEntry(facultiesListItem, sortedListItem.value));
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Результаты'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Результат теста:",
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
                              item.key.get('shortName'),
                              style: TextStyle(fontSize: 26, color: mainColor),
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
                              maxWidth: MediaQuery.of(context).size.width * 0.7),
                          child: CarouselSlider(
                            items: [
                              for (var item in sortedQueryList)
                                if (item.value < maxFrequency)
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 50,
                                        maxWidth:
                                        MediaQuery.of(context).size.width * 0.8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: TextButton(
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
                                        item.key.get('shortName'),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                            ],
                            options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * 0.2,
                                scrollDirection: Axis.vertical,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.35,
                                enlargeCenterPage: true,
                                scrollPhysics: PageScrollPhysics()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainMenu(),
                          ));
                    },
                    fillColor: Colors.white,
                    elevation: 10,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Пройти тест заново",
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

  }
}
